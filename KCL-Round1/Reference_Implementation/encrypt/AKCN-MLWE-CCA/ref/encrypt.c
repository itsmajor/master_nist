#include <time.h>
#include <stdlib.h>
#include <openssl/sha.h>  
#include <openssl/crypto.h>
#include <string.h>

#include "parameter.h"
#include "io.h"
#include "polynomial.h"
#include "vector.h"
#include "api.h"
#include "rng.h"
#include "myOpenSSL.h"


// Algorithm 32 in the document
void crypto_encrypt_keypair_KAT(
		unsigned char * pk,  
		unsigned char * sk, 
		const unsigned char * seed);


// Algorithm 33 in the document
void crypto_encrypt_KAT(
		unsigned char * c, 
		unsigned long long * clen,
		const unsigned char * m, 
		unsigned long long mlen,
		const unsigned char * pk,
		const unsigned char * enc_seed);

		
// Algorithm 32 in the document
int crypto_encrypt_keypair(unsigned char * pk,  unsigned char * sk)
{
	// keypair_seed = matrix_seed + noise_seed + z_seed
    unsigned char keypair_seed[KEYPAIR_SEED_BYTES];
    randombytes(keypair_seed, KEYPAIR_SEED_BYTES);

    crypto_encrypt_keypair_KAT(pk, sk, keypair_seed);

	return 0;
}


// Algorithm 32 in the document
void crypto_encrypt_keypair_KAT(
		unsigned char * pk,  
		unsigned char * sk, 
		const unsigned char * keypair_seed)
{
    unsigned int i;
	unsigned int nonce = 0;

	unsigned char matrix_seed[MATRIX_SEED_BYTES];
	unsigned char noise_seed[NOISE_SEED_BYTES];
	unsigned char z_seed[Z_SEED_BYTES];
	
	memcpy(matrix_seed, keypair_seed, MATRIX_SEED_BYTES);
	memcpy(noise_seed, keypair_seed+MATRIX_SEED_BYTES, NOISE_SEED_BYTES);
	memcpy(z_seed, keypair_seed+(MATRIX_SEED_BYTES+NOISE_SEED_BYTES), Z_SEED_BYTES);
	
	Polynomial A[MLWE_ELL][MLWE_ELL];
	Polynomial X1[MLWE_ELL], Y1[MLWE_ELL];
	Polynomial small_poly;

	{{
		// Line #3, Algorithm 32: A:=Gen(seed)
		Get_uniform_matrix(A, matrix_seed, 0);
	
	 	// Line #4, Algorithm 32: X1 <- (noise_seed,nonce)
		for(i=nonce=0; i<MLWE_ELL; i++)
			Get_small_poly(X1+i, noise_seed, nonce++);
	
	 	// Line #5, Algorithm 32: Y1 = truncated(A*X1 + E1)
		for(i=0; i<MLWE_ELL; i++)
		{
			Vector_multiply(Y1+i, A[i], X1);
			Get_small_poly(&small_poly, noise_seed, nonce++);// small_poly = E1[i]
			Poly_add_then_truncate(Y1+i, &small_poly, 1);
		}
	}}
	
	{{ // Line #6, Algorithm 32: pack pk =(Y1, matrix_seed), sk = (X1, z, (Y1, matrix_seed))
		pack_truncated_vector(pk+Y1_OFFSET_IN_PK, Y1);
		pack_seed(pk+MATRIX_SEED_OFFSET_IN_PK, matrix_seed, MATRIX_SEED_BYTES);
		
		pack_small_vector(sk+X1_OFFSET_IN_SK, X1);
		pack_seed(sk+Z_SEED_OFFSET_IN_SK, z_seed, Z_SEED_BYTES);
		pack_seed(sk+PK_OFFSET_IN_SK, pk, PUBLICKEY_BYTES);
	}}
}


// Algorithm 33 in the document
// pk = (Y1, matrix_seed); ct = (c1=(Y2, Signal), c2)
// enc_seed = the seed to generate S_table
int crypto_encrypt(
		unsigned char * c, 
		unsigned long long * clen,
		const unsigned char * m, 
		unsigned long long mlen,
		const unsigned char * pk)
{
	// initialize the seed to generate S_table
	unsigned char enc_seed[ENC_SEED_BYTES];
	randombytes(enc_seed, ENC_SEED_BYTES);
 
	crypto_encrypt_KAT(c, clen, m, mlen, pk, enc_seed);
 
	return 0;
}


// Algorithm 33 in the document
void crypto_encrypt_KAT(
		unsigned char * c, 
		unsigned long long * clen,
		const unsigned char * m, 
		unsigned long long mlen,
		const unsigned char * pk,
		const unsigned char * enc_seed)
{
	unsigned int i;

	Polynomial recovered_B[MLWE_ELL][MLWE_ELL];
	Polynomial recovered_Y1[MLWE_ELL];
	
	unsigned char * S_string = enc_seed;
	
	unsigned char omega_string[MLWE_N/8];
	unsigned char r1_string[NOISE_SEED_BYTES];

	unsigned int S_table[MLWE_N];
	
	Polynomial X2[MLWE_ELL];
	Polynomial small_poly;
	unsigned char nonce = 0;

	Polynomial Y2[MLWE_ELL];
	Polynomial Sigma2;

	unsigned int Signal[MLWE_N];

	unsigned char AES_ecb_key[32];
	
	unsigned char * c1_string = c+0;
	unsigned char * c2_string = c+(TRUNCATED_VECTOR_BYTES+SIGNAL_BYTES);

	{{ // recovery from pk = (Y1, matrix_seed)
		unpack_truncated_vector(recovered_Y1, pk+Y1_OFFSET_IN_PK);
		Vector_detruncate(recovered_Y1);
		
		unsigned char local_matrix_seed[MATRIX_SEED_BYTES];
		unpack_seed(local_matrix_seed, pk+MATRIX_SEED_OFFSET_IN_PK, MATRIX_SEED_BYTES);
		Get_uniform_matrix(recovered_B, local_matrix_seed, 1);
	}}
	
	{{ // Line #2, Algorithm 33: set the random coin S		
		unpack_key(S_table, enc_seed+0);
	}}

	
	{{ // Line #3, Algorithm 33: (omega, r1) <- G(pk, S)
		unsigned char output_length = MLWE_N/8 + NOISE_SEED_BYTES;
		unsigned char sha1_output[output_length];
		
		SHA1_hash2(
				sha1_output, output_length, 	// local_table
				pk+0, PUBLICKEY_BYTES, 			// pk
				enc_seed+0, ENC_SEED_BYTES);	// S

		memcpy(omega_string, sha1_output, MLWE_N/8);
		memcpy(r1_string, sha1_output+MLWE_N/8, NOISE_SEED_BYTES);
	}}
	
	{{ // Line #4, Algorithm 33: (X2, E2, E_sigma) <- Sample(r1);
		for(i=0; i<MLWE_ELL; i++)
			Get_small_poly(X2+i, r1_string, nonce++);
	}}
	
	{{ 
		// Line #5, Algorithm 33: Y2 = truncated(A^T X2+ E2)
		for(i=0; i<MLWE_ELL; i++)
		{
			Vector_multiply(Y2+i, recovered_B[i], X2);
			Get_small_poly(&small_poly, r1_string, nonce++);// small_poly = E2[i];
			Poly_add_then_truncate(Y2+i, &small_poly, 1);
		}
	
 		// Line #6, Algorithm 33: Sigma2 = detruncate(Y1) * X2 + E_sigma
		Vector_multiply(&Sigma2, recovered_Y1, X2);
		Get_small_poly(&small_poly, r1_string, nonce++);// small_poly = E_sigma;
		Poly_add_then_truncate(&Sigma2, &small_poly, 0);

		// Line #7, Algorithm 33: Signal <- AKCN_Con(Sigma2, S)
		Poly_AKCN_Con(Signal, &Sigma2, S_table);
	}}
	
	{{	// Line #8, Algorithm 33: K = Hash(S, c1), where c1 = (Y2, Signal)
		// First, pack c1 = (Y2, Signal)
		pack_truncated_vector(c1_string+0, Y2);
		pack_signal(c1_string+TRUNCATED_VECTOR_BYTES, Signal);
		
		// Then, hash 
		SHA1_hash2(AES_ecb_key, 32, S_string, MLWE_N/8, c1_string+0, C1_BYTES);
	}}
	
	{{ // Line #9, Algorithm 33: compute C2. 
		unsigned int padded_msg_len = (mlen+16)/16*16;
		*clen = C1_BYTES + 32 + padded_msg_len;
		
		unsigned char msg[padded_msg_len];
		memcpy(msg, m, mlen);
		msg[mlen] = 0x00;
		for(i=mlen+1; i<padded_msg_len; i++)
			msg[i] = 0xFF;
		
		unsigned char pt[MLWE_N/8+padded_msg_len];	
		memcpy(pt, omega_string, MLWE_N/8);
		memcpy(pt+MLWE_N/8, msg, padded_msg_len);
		My_AES_ecb_encrypt(c2_string, pt, MLWE_N/8+padded_msg_len, AES_ecb_key); 
	}}
	
	// Note: each component in the ciphertext has already been packed previously.
}


// Algorithm 34 in the document
int crypto_encrypt_open(
		unsigned char * m, 
		unsigned long long * mlen,
		const unsigned char * c, 
		unsigned long long clen,
		const unsigned char * sk)
{
	unsigned int i, j;
	unsigned int nonce=0;

	Polynomial recovered_B[MLWE_ELL][MLWE_ELL];	// = A^transpose 
	Polynomial recovered_X1[MLWE_ELL];
	Polynomial recovered_Y1[MLWE_ELL];
	Polynomial recovered_Y2[MLWE_ELL];
	unsigned char recovered_omega_string[MLWE_N/8];
	unsigned int recovered_Signal[MLWE_N];
	
	unsigned int Signal[MLWE_N];

	Polynomial Sigma1, Sigma2;
	Polynomial X2[MLWE_ELL];
	Polynomial Y2[MLWE_ELL];
	Polynomial small_poly;
	
	unsigned int S_table[MLWE_N];
	unsigned char S_string[MLWE_N/8];	
	
	unsigned char AES_ecb_key[32];
	
	unsigned char omega_string[MLWE_N/8];
	unsigned char r1_string[NOISE_SEED_BYTES];
	
	unsigned char recovered_pt[clen- C1_BYTES];

	unsigned char success0 = 0;		// for M
	unsigned char success1 = 0;		// for Y2
	unsigned char success2 = 0;		// for Signal
	unsigned char success3 = 0;		// for omega
	
	
	{{ // recover B=A^T, X1, Y1, Y2, Signal
		// recover the matrix B
		unsigned char local_matrix_seed[MATRIX_SEED_BYTES];
		unpack_seed(
				local_matrix_seed, 
				sk+MATRIX_SEED_OFFSET_IN_SK, 
				MATRIX_SEED_BYTES);
		Get_uniform_matrix(recovered_B, local_matrix_seed, 1);
		
		unpack_small_vector(recovered_X1, sk+ X1_OFFSET_IN_SK);	// recover X1
		unpack_signal(recovered_Signal, c + SIGNAL_OFFSET_IN_CT); // recover Signal
		
		unpack_truncated_vector(recovered_Y1, sk+Y1_OFFSET_IN_SK); // recover Y1
		Vector_detruncate(recovered_Y1);
		
		unpack_truncated_vector(recovered_Y2, c + Y2_OFFSET_IN_CT); // recover Y2
		Vector_detruncate(recovered_Y2);
	}}
	
	{{  // Lines #2-4, Algorithm 34.
		// Line #2, Sigma1 = X1^T * detruncate(Y2);
		Vector_multiply(&Sigma1, recovered_X1, recovered_Y2);
	
	 	// Line #3, \tilde{S} = Rec(Sigma1, Signal)
		Poly_AKCN_Rec(S_table, &Sigma1, recovered_Signal);
		pack_key(S_string, S_table);

		// Line #4, K' = Hash(\tilde{S}, c1), where c1 = (Y2, Signal)
		SHA1_hash2(AES_ecb_key, 32, S_string, MLWE_N/8, c + C1_OFFSET_IN_CT, C1_BYTES);
	}}
	
	{{ // Line #5, Algorithm 34: msg <- Dec(K, c2)
		success0 = 1;
		
		My_AES_ecb_decrypt(
				recovered_pt, 
				c+(TRUNCATED_VECTOR_BYTES+SIGNAL_BYTES), 
				clen- C1_BYTES, 
				AES_ecb_key);

		memcpy(recovered_omega_string, recovered_pt, MLWE_N/8);
		
		for(i=clen- C1_BYTES-1; i >= MLWE_N/8 && recovered_pt[i] == 0xFF; i--);
		if(recovered_pt[i]!=0x00 || i<MLWE_N/8 || (i+16)/16*16!=(clen- C1_BYTES))
			success0 = 0;
		else 
			*mlen = (i-MLWE_N/8);
	}}
	
	{{	// Lines # 6 -- 11, Algorithm 34: 
		// \bar{S} = Hash(z, c1), where c1 = (Y2, Signal)
		unsigned char sha1_output[32];
		SHA1_hash2(
				sha1_output, 32,  
				sk + Z_SEED_OFFSET_IN_SK, Z_SEED_BYTES, 
				c + C1_OFFSET_IN_CT, C1_BYTES);
				
		if(success0 == 0)
			memcpy(S_string, sha1_output, 32);
	}}

	{{
		// Line #12, Algorithm 34: (omega, r1) <- G(pk, S)
		unsigned char sha1_ouput[MLWE_N/8 + NOISE_SEED_BYTES];
		SHA1_hash2(
				sha1_ouput, MLWE_N/8 + NOISE_SEED_BYTES,  
				sk + PK_OFFSET_IN_SK, PUBLICKEY_BYTES, 
				S_string, MLWE_N/8);
		memcpy(omega_string, sha1_ouput, MLWE_N/8);
		memcpy(r1_string, sha1_ouput+MLWE_N/8, NOISE_SEED_BYTES);
		
		// Line #13, Algorithm 34: (X2, E2, E_sigma) <- Sample(r1);
		for(i=nonce=0; i<MLWE_ELL; i++)
			Get_small_poly(X2+i, r1_string, nonce++);
	
 		// Line #14, Algorithm 34: Y2 = truncated(A^T * X2+ E2)
		for(i=0; i<MLWE_ELL; i++)
		{
			Vector_multiply(Y2+i, recovered_B[i], X2);
			Get_small_poly(&small_poly, r1_string, nonce++);// small_poly = E2[i];
			Poly_add_then_truncate(Y2+i, &small_poly, 1);
		}
		
		// Line #15, Algorithm 34: Sigma2 = detruncate(Y1) * X2 + E_sigma
		Vector_multiply(&Sigma2, recovered_Y1, X2);
		Get_small_poly(&small_poly, r1_string, nonce++);// small_poly = E_sigma;
		Poly_add_then_truncate(&Sigma2, &small_poly, 0);
	
		// Line #16, Algorithm 34: Signal <- Con(Sigma2, S_table);
		Poly_AKCN_Con(Signal, &Sigma2, S_table);
	}}
	
	{{	// set flags. 
		// set success1
		Vector_truncate(recovered_Y2);	// necessary
		for(success1=1, i=0; i<MLWE_ELL && success1; i++)
			for(j=0; j<MLWE_N; j++)
				if(recovered_Y2[i].coefficients[j] != Y2[i].coefficients[j])
					success1 = 0;
	
		// set success2
		for(success2=1, i=0; i<MLWE_N && success2; i++)
			if(Signal[i] != recovered_Signal[i])
				success2 = 0;
	
	 	// set success3
		for(success3=1, i=0; i<MLWE_N/8 && success3; i++)
			if(omega_string[i] != recovered_omega_string[i])
				success3 = 0;
	}}
	
	{{ 	// Lines 18 - 22, Algorithm 34
		if(success0 && success1 && success2 && success3)
		{
			memcpy(m, recovered_pt+MLWE_N/8, *mlen);
			return 0;
		}
		else
		{
			*mlen = 0;
			return 1;
		}
	}}
}
