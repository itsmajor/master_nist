/*
We modifiy NIST provided file PQCgenKAT_kem.c to generate our intermediate values for 3 aspects (keypair generation, encapsulation
and decapsulation) of our kem schemes.
*/ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "rng.h"   
#include "api.h" 
#include "io.h"
#include "polynomial.h"
#include "vector.h"      

#define	MAX_MARKER_LEN		50
#define KAT_SUCCESS          0
#define KAT_FILE_OPEN_ERROR -1
#define KAT_DATA_ERROR      -3
#define KAT_CRYPTO_FAILURE  -4


void	fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L);

int
main()
{
    char                fn_keypair_vector[32], fn_enc_vector[32], fn_dec_vector[32];
    FILE                *fp_keypair_vector, *fp_enc_vector, *fp_dec_vector;
    unsigned char       seed[10][48];
    unsigned char       entropy_input[48];
    unsigned char       ct[CRYPTO_CIPHERTEXTBYTES], ss[CRYPTO_BYTES], ss1[CRYPTO_BYTES];
    int                 count;
    int                 done;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val;
 

    
    // Create the REQUEST file
    sprintf(fn_keypair_vector, "keypair_intermediate.txt");
    if ( (fp_keypair_vector = fopen(fn_keypair_vector, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_keypair_vector);
        return KAT_FILE_OPEN_ERROR;
    }

 
    sprintf(fn_enc_vector, "enc_intermediate.txt");
    if ( (fp_enc_vector = fopen(fn_enc_vector, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_enc_vector);
        return KAT_FILE_OPEN_ERROR;
    }
 
    sprintf(fn_dec_vector, "dec_intermediate.txt");
    if ( (fp_dec_vector = fopen(fn_dec_vector, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_dec_vector);
        return KAT_FILE_OPEN_ERROR;
    }

// print header information

fprintf(fp_keypair_vector, "#Algorithm name: %s\n#Test name: crypto_kem_keypair_KAT intermediate values \n\n", CRYPTO_ALGNAME); 
fprintf(fp_keypair_vector, "#This file includes 100 intermediate values sets for function crypto_kem_keypair_KAT in kem.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_keypair_vector, "#Function: void crypto_kem_keypair_KAT( unsigned char * pk,   unsigned char * sk,  const unsigned char * seed);  \n\n" );

 

fprintf(fp_enc_vector, "#Algorithm name: %s\n#Test name: crypto_kem_enc_KAT intermediate values \n\n", CRYPTO_ALGNAME); 
fprintf(fp_enc_vector, "#This file includes 100 intermediate values sets for function crypto_kem_enc_KAT in kem.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_enc_vector, "#Function: void crypto_kem_enc_KAT( unsigned char * ct, unsigned char * ss,  const unsigned char * pk, const unsigned char * noise_seed);  \n\n" );
 


fprintf(fp_dec_vector, "#Algorithm name: %s\n#Test name: crypto_kem_dec intermediate values \n\n", CRYPTO_ALGNAME); 
fprintf(fp_dec_vector, "#This file includes 100 intermediate values sets for function crypto_kem_dec in kem.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_dec_vector, "#Function: void int crypto_kem_dec( unsigned char * ss,  const unsigned char * ct, const unsigned char * sk);  \n\n" );
 
 

    
// generate 100 initial seed
    for (int i=0; i<48; i++)
        entropy_input[i] = i;
    randombytes_init(entropy_input, NULL, 256);
    for (int i=0; i<10; i++) 
    {
    	randombytes(seed[i], 48);
    }
 

// generate 100 KAT data in three files
    for (int i=0; i<10; i++) {
 
        randombytes_init(seed[i], NULL, 256);
 

//////////////////////////////////////////////////////////////////////////////////////       
        
        // Generate the public/private keypair

    unsigned char seedkeypair[MATRIX_SEED_BYTES+NOISE_SEED_BYTES];
    randombytes(seedkeypair, MATRIX_SEED_BYTES+NOISE_SEED_BYTES);

    fprintf(fp_keypair_vector, "***Input and output tuples number %d ************************* \n\n", i+1 );

    crypto_kem_keypair_KAT_Vectors(pk, sk, seedkeypair, fp_keypair_vector);

 
//////////////////////////////////////////////////////////////////////////////////

        // Generate the crypto_kem_enc_KAT tuples
	unsigned char seedenc[NOISE_SEED_BYTES];
	randombytes(seedenc, NOISE_SEED_BYTES);

        fprintf(fp_enc_vector, "***Input and output tuples number %d ************************* \n\n", i+1 );

        crypto_kem_enc_KAT_Vectors(ct, ss, pk, seedenc, fp_enc_vector);

 
//////////////////////////////////////////////////////////////////////////////////
 

     fprintf(fp_dec_vector, "***Input and output tuples number %d ************************* \n\n", i+1 );
         // Generate the crypto_kem_dec tuples
        crypto_kem_dec_Vectors(ss1, ct, sk, fp_dec_vector);  
        

     fprintf(fp_dec_vector, "\nThe output(ss1) will be as following: \n"  );

 
        fprintBstr(fp_dec_vector, "ss1 = ", ss1, CRYPTO_BYTES);
        
        fprintf(fp_dec_vector, "\n");
 
//////////////////////////////////////////////////////////////////////////////////
        if ( memcmp(ss, ss1, CRYPTO_BYTES) ) {
            printf("crypto_kem_dec returned bad 'ss' value\n");
            return KAT_CRYPTO_FAILURE;
        }

 

    }
    fclose(fp_keypair_vector);
    
 
    
    fclose(fp_enc_vector);
    fclose(fp_dec_vector);

    return KAT_SUCCESS;
}

//it has the same fucntion with crypto_kem_dec in kem.c file, but this fucntion print out intermediate values in the dec_intermediate.txt file
void crypto_kem_dec_Vectors(
		unsigned char * ss,
		const unsigned char * ct,
		const unsigned char * sk, FILE  *fp_dec_vector)
{


fprintf(fp_dec_vector, "when input of crypto_kem_dec(ct and sk) are as following:  \n"  );
fprintBstr(fp_dec_vector, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);
fprintBstr(fp_dec_vector, "sk = ", sk, CRYPTO_SECRETKEYBYTES);

	Polynomial X1[MLWE_ELL];
	Polynomial Sigma1;
	Polynomial Y2[MLWE_ELL];
	unsigned int Signal[MLWE_N];
	unsigned int Key1[MLWE_N];

	{{ // unpack
		unpack_ct(Y2, Signal, ct);	// unpack ct; ciphertext = (Y2, Signal)
		Vector_detruncate(Y2);
		
		unpack_sk(X1, sk);			// unpack secret key sk
	}}


fprintf(fp_dec_vector, "\nPolynomial vector Y2 after Vector_detruncate will be:  \n"  );
printpolyvec(Y2, fp_dec_vector);

	 {{ // computation
		// Line #1, Algorithm 28
		Vector_multiply(&Sigma1, X1, Y2);
		


fprintf(fp_dec_vector, "\n\nPolynomial  Sigma1 after Vector_multiply will be:  \n"  );
 for(int k = 0; k < MLWE_N; k++)
		{ 
		  fprintf(fp_dec_vector, "%X",  Sigma1.coefficients[k]);       	    
		}


		// Line #2, Algorithm 28
		Poly_OKCN_Rec(Key1, &Sigma1, Signal);
	}}
fprintf(fp_dec_vector, "\n");
		 

	{{ // pack the generated key
		pack_key(ss, Key1);
	}}

 
}


//it has the same fucntion with crypto_kem_keypair_KAT in kem.c file, but this fucntion print out intermediate values in the keypair_intermediate.txt file
void crypto_kem_keypair_KAT_Vectors(
		unsigned char * pk,  
		unsigned char * sk, 
		const unsigned char * seed, FILE  *fp_keypair_vector)
{


fprintf(fp_keypair_vector, "When the input value seed is as following:  \n"  );
fprintBstr(fp_keypair_vector, "seed = ", seed, MATRIX_SEED_BYTES+NOISE_SEED_BYTES);


    unsigned int i;

	unsigned char * matrix_seed  = pk+(TRUNCATED_POLY_BYTES * MLWE_ELL);
	unsigned char noise_seed[NOISE_SEED_BYTES];
	unsigned int nonce = 0;

	Polynomial Y1[MLWE_ELL];
	Polynomial X1[MLWE_ELL];
	Polynomial small_poly;
	Polynomial A[MLWE_ELL][MLWE_ELL];
	
	{{ // initialize the seeds
		memcpy(matrix_seed, seed, MATRIX_SEED_BYTES);
		memcpy(noise_seed, seed+MATRIX_SEED_BYTES, NOISE_SEED_BYTES);	

	}}
	
	{{	// Line #2, Algorithm 26: A := Gen(seed)
		// Note: assume the generated matrix A is already in the NTT form. 
		Get_uniform_matrix(A, matrix_seed, 0);	// 0 implies A, not transpose(A)
	}}

fprintf(fp_keypair_vector, "\nPolynomial matrix A after Get_uniform_matrix will be:  \n"  );
printpolymatrix(A, fp_keypair_vector);

	{{  // Line #3, Algorithm 26
		// Note: the small polynomial vector E1[...] will be generated when necessary, in order to save memory space. 
		for(i=0; i<MLWE_ELL; i++)
			Get_small_poly(X1+i, noise_seed, nonce++);
		
	}}
	


fprintf(fp_keypair_vector, "\nPolynomial vector X1 after Get_small_poly will be:  \n"  );
printpolyvec(X1, fp_keypair_vector);

	pack_sk(sk, X1);	// pack the secret key X1



	{{	// Line #4, Algorithm 26: Y1 = truncate(A*X1+E1)
		Vector_pre_NTT_computation(X1);
		Vector_NTT_transform(X1, 1);

fprintf(fp_keypair_vector, "\nPolynomial vector X1 after Vector_NTT_transform will be:  \n"  );
printpolyvec(X1, fp_keypair_vector);

		for(i=0; i<MLWE_ELL; i++)
		{
			Vector_NTT_componentwise_multiply_and_add(Y1+i, A[i], X1);
			Poly_NTT_transform(Y1+i, -1);
			Poly_post_NTT_computation(Y1+i);
			
			Get_small_poly(&small_poly, noise_seed, nonce++);// small_poly = E1[i]
			Poly_add_then_truncate(Y1+i, &small_poly, 1); //Here, addition and truncation are both conducted. 
		}
	}}



 
fprintf(fp_keypair_vector, "\n\nPolynomial vector Y1 after computation will be:  \n"  );
printpolyvec(Y1, fp_keypair_vector);

       {{	// Line #5, Algorithm 26
		// Note: the seed to generate the matrix A, 
		// and the secret key have already been packed previously. 
		pack_truncated_vector(pk, Y1);
	}}



fprintf(fp_keypair_vector, "\n\nThe output of crypto_kem_keypair_KAT ( pk and sk ) will be as following: \n"  );
        fprintBstr(fp_keypair_vector, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
        fprintBstr(fp_keypair_vector, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
        fprintf(fp_keypair_vector, "\n\n");


}


//it has the same fucntion with crypto_kem_enc_KAT in kem.c file, but this fucntion print out intermediate values in the enc_intermediate.txt file
void crypto_kem_enc_KAT_Vectors(
		unsigned char * ct,
		unsigned char * ss, 
		const unsigned char * pk,
		const unsigned char * noise_seed, FILE  *fp_enc_vector)
{

fprintf(fp_enc_vector, "When input seed and pk are as following: \n"  );
fprintBstr(fp_enc_vector, "seed = ", noise_seed, NOISE_SEED_BYTES);
fprintBstr(fp_enc_vector, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);


  unsigned char nonce = 0;
	unsigned int i;

	Polynomial A_transpose[MLWE_ELL][MLWE_ELL];
	Polynomial X2[MLWE_ELL], Sigma2;
	Polynomial small_poly;
	Polynomial Y1[MLWE_ELL];
	Polynomial Y2[MLWE_ELL];
	unsigned int Signal[MLWE_N]; 
	unsigned int Key2[MLWE_N];



	{{ 	// unpack pk = (Y1, seed) -> (Y1, A_transposed)
		// Note: A_transposed is assumed in its NTT form. 
		unpack_truncated_vector(Y1, pk+0);
		Vector_detruncate(Y1);
		
		Get_uniform_matrix(
			A_transpose, 
			pk+(TRUNCATED_POLY_BYTES * MLWE_ELL), 
			1);		// 1 indicates A^t, not A. 
	}}

fprintf(fp_enc_vector, "\nPolynomial matrix A_transpose after Get_uniform_matrix will be:  \n"  );
printpolymatrix(A_transpose, fp_enc_vector);



	{{	// Line #2, Algorithm 27
		// Note: E2[...], and E_sigma are generated when necessary, 
		// so as to save memory space. 
		for(i=0; i < MLWE_ELL; i++)
			Get_small_poly(X2+i, noise_seed, nonce++);
	}}

fprintf(fp_enc_vector, "\nPolynomial vector X2 after Get_small_poly will be:  \n"  );
printpolymatrix(X2, fp_enc_vector);
		
{{	// Lines #3 & #4, Algorithm 27: 
		// Y2 = truncate(A^transpose * X2 + E2)
		// Sigma2 = 2^t * Y1^T * X2 + E_sigma
		Vector_pre_NTT_computation(Y1);
		Vector_NTT_transform(Y1, 1);
		
		Vector_pre_NTT_computation(X2);
		Vector_NTT_transform(X2, 1); 

fprintf(fp_enc_vector, "\nPolynomial vector Y1 after Vector_NTT_transform will be:  \n"  );
printpolymatrix(Y1, fp_enc_vector); 
		
		for(i=0; i<MLWE_ELL; i++)
		{
			Vector_NTT_componentwise_multiply_and_add(Y2+i, A_transpose[i], X2);
			Poly_NTT_transform(Y2+i, -1);
			Poly_post_NTT_computation(Y2+i);
			
			Get_small_poly(&small_poly, noise_seed, nonce++); // small_poly = E2[i]
			Poly_add_then_truncate(Y2+i, &small_poly, 1);	// 1 indicates truncation operation is necessary. 
		}
		
		Vector_NTT_componentwise_multiply_and_add(&Sigma2, Y1, X2);
		Poly_NTT_transform(&Sigma2, -1);
		Poly_post_NTT_computation(&Sigma2);
		
		Get_small_poly(&small_poly, noise_seed, nonce++); // small_poly = E_sigma
		Poly_add_then_truncate(&Sigma2, &small_poly, 0);
	}}


 
 

		 

    {{ // Line #5, Algorithm 27: (Key2, Signal) <- Con(Sigma2)
		unsigned char diversifier[8];
		for(i=0; i<8; i++)
			diversifier[i] = noise_seed[i]/2;
		unsigned char local_seed[NOISE_SEED_BYTES+1];
		
		for(i=0; i<NOISE_SEED_BYTES; i++)
			local_seed[i] = noise_seed[i];
		local_seed[NOISE_SEED_BYTES] = nonce;

		AES_XOF_struct aes_state;
		seedexpander_init(&aes_state, local_seed, diversifier, MLWE_N);
		seedexpander(&aes_state, noise_seed, MLWE_N/8);

		Poly_OKCN_Con(Key2, Signal, &Sigma2, local_seed);
	}} 

	{{	// Line #6, Algorithm 27: packing
		pack_ct(ct, Y2, Signal);
		pack_key(ss, Key2);
	}}



fprintf(fp_enc_vector, "\nThe output of crypto_kem_enc_KAT ( ct and ss ) will be as following: \n"  );

        fprintBstr(fp_enc_vector, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);
        fprintBstr(fp_enc_vector, "ss = ", ss, CRYPTO_BYTES);
        
        fprintf(fp_enc_vector, "\n");




}

  
 

void printpolymatrix(Polynomial A[MLWE_ELL][MLWE_ELL], FILE  *fp  )
{
	 for(int  i= 0; i< MLWE_ELL; i++)
	{
           printpolyvec(A[i], fp );
           fprintf(fp, "\n");
	}
}
 
void printpolyvec(Polynomial A[MLWE_ELL] , FILE  *fp  ){

	for(int i=0; i<MLWE_ELL; i++)
	{  
		 for(int k = 0; k < MLWE_N; k++)
		{ 
		  fprintf(fp, "%X",  A[i].coefficients[k]);       	    
		}
 
                fprintf(fp, "      ");
	} 
}

// we use fprintBstr function in NIST provided file PQCgenKAT_kem.c here
void
fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L)
{
	unsigned long long  i;

	fprintf(fp, "%s", S);

	for ( i=0; i<L; i++ )
		fprintf(fp, "%02X", A[i]);

	if ( L == 0 )
		fprintf(fp, "00");

	fprintf(fp, "\n");
}

