#include "api.h"

#include "ntt_constants.h"
#include "rng.h"

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <immintrin.h>
#include <openssl/sha.h>

#define CRYPTO_R_n 512
#define CRYPTO_R_k 1
#define CRYPTO_R_logq 16
#define CRYPTO_R_sigma 25
#define CRYPTO_R_t 1
#define CRYPTO_R_NTT ntt_512_40961
#define CRYPTO_R_INTT intt_512_40961
#define CRYPTO_R_q 40961
#define CRYPTO_R_msg 256
#define CRYPTO_N_INV 40881


/* Converts int array to octect string */
void _BINT_to_OS(unsigned char *a, unsigned int *in, int os_len)
{

	int i;

	for (i = 0; i < os_len; i++)
	{
		a[i] = (in[i >> 2] >> (24 - 8 * (i % 4))) & 0xff;
	}


}

/* Converts octect string to int array*/
void _OS_to_BINT(unsigned int *a, unsigned char *os, int bint_len)
{
	int i;


	for (i = 0; i < (bint_len); i++)
	{
		a[i] = ((unsigned int)os[(i << 2)] & 0xff) << 24;
		a[i] ^= ((unsigned int)os[(i << 2) + 1] & 0xff) << 16;
		a[i] ^= ((unsigned int)os[(i << 2) + 2] & 0xff) << 8;
		a[i] ^= ((unsigned int)os[(i << 2) + 3] & 0xff);

	}

}

/* SHA256 where input and output are stored in int array */
void SHA256_INT (unsigned int *Msg, unsigned int MLen, unsigned int *Digest)
{
	unsigned char *M_tmp;
	unsigned char D_tmp[32];

	M_tmp = (unsigned char*)calloc(MLen, sizeof(unsigned char));
	_BINT_to_OS(M_tmp, Msg, MLen);
	
	SHA256(M_tmp, MLen, D_tmp);

	_OS_to_BINT (Digest, D_tmp, 8);


}

/* SHA256 where output is stored in octect string */
void SHA256_OS (unsigned int *Msg, unsigned int MLen, unsigned char *Digest)
{
	unsigned char *M_tmp;
	unsigned char D_tmp[32];

	M_tmp = (unsigned char*)calloc(MLen, sizeof(unsigned char));
	_BINT_to_OS(M_tmp, Msg, MLen);
	
	SHA256(M_tmp, MLen, Digest);


}

/* Generates random number modulo q */
int random_modq()
{
	unsigned char r[2];
	int tmp;
	int check;

	randombytes(r,2);
	tmp = (r[0] & 0xff) | ((r[1] & 0xff) << 8);
	check = tmp % CRYPTO_R_q;

	return check;
}


int CDT_TABLE[54] = { 65, 130, 196, 259, 323, 387, 450, 512, 574, 635, 695,754, 812, 869, 924, 978, 1031, 1082, 1132, 1180, 1227, 1272, 1316, 1358, 1399, 1438, 1476, 1512, 1546,
1580, 1611, 1641, 1669, 1696, 1721, 1745, 1768, 1789, 1809, 1828, 1846, 1863, 1878, 1892, 1905, 1917, 1929, 1940, 1950, 1959, 1967, 1974, 1980, 1985 };


/* Gaussain sampling using CDT table */
int Sample_CDT()
{
	unsigned char rnd[3];
	int r, sign, sample, tmp;
	int i;

	randombytes(rnd,3);
	tmp = ((rnd[0]&0xff)<<16) | ((rnd[1]&0xff)<<8) | ((rnd[2]&0xff));

	r = tmp & 0x7ff; //11bit
	sign = ((tmp&0x800)>>11) & 1;
	sample = 0;

	for (i = 0; i<54 - 1; i++)
		sample += (CDT_TABLE[i] - r) >> 11;

	sample = ((-sign) ^ sample) + sign;
	return sample;

}

/* Returns x mod q */
int fmodq(int x)
{
	double c = x%CRYPTO_R_q;
	if (c < 0) c = c + CRYPTO_R_q;

	return (int)c;

}

/* Coefficient-wise polynomial multiplication :: c=a*b */
void p_mul(int *a, int *b, int *c, unsigned int N)
{ 
	int i;

	for (i = 0; i < N; i++) 
	{
		c[i] = ((long long int)(a[i] * b[i])) % CRYPTO_R_q;

	}
}

/* Coefficient-wise polynomial multiplication and addition :: c=a*b+c */
void p_muladd(int *a, int *b, int *c, int *d, int N)
{
	int i;

	for (i = 0; i < N; i++) 
	{
		d[i]=fmodq(a[i] * b[i] + c[i]);

	}
}

/* Polynomial addition c=a+b */
void p_add(int *a, int *b, int *c, int p, int N)
{ 
	int i, j;


	for (i = 0; i < N; i++)
	{
		c[i] = (a[i] + b[i]) % p;
		if (c[i]<0) c[i] += p;

	}
}

/* NTT preserving input */
void NTT_new(int *aout, int *a, const int *psi, int N)
{
	int t;
	int j1, j2, i, j, m;
	int S, U, V;
	int *a_tmp;
	t = N;

	a_tmp = (int*)calloc(CRYPTO_R_n, sizeof(int));
	memcpy(a_tmp, a, CRYPTO_R_n * sizeof(int));
	for (m = 1; m < N; m = m << 1)
	{
		t = t >> 1;
		for (i = 0; i < m; i++)
		{
			j1 = 2 * i*t;
			j2 = j1 + t - 1;
			S = psi[m + i];
			for (j = j1; j <= j2; j++)
			{
				U = a_tmp[j];
				V = fmodq(a_tmp[j + t] * S);
				a_tmp[j] = fmodq((U + V));
				a_tmp[j + t] = fmodq(U - V);


			}

		}
	}

	memcpy(aout, a_tmp, CRYPTO_R_n * sizeof(int));
	free(a_tmp);

}


void NTT(int *a, const int *psi, int N)
{
	int t;
	int j1, j2, i, j, m;
	int S, U, V;

	t = N;

	for (m = 1; m < N; m = m << 1)
	{
		t = t >> 1;
		for (i = 0; i < m; i++)
		{
			j1 = 2 * i*t;
			j2 = j1 + t - 1;
			S = psi[m + i];
			for (j = j1; j <= j2; j++)
			{
				U = a[j];
				V = fmodq(a[j + t] * S);
				a[j] = fmodq((U + V));
				a[j + t] = fmodq(U - V);

			}

		}
	}


}

void INTT(int *a, const int *inv_psi, int Ninv, int N)
{
	unsigned int t, h;
	unsigned int j1, j2, i, j, m;
	int S, U, V;

	t = 1;
	for (m = N; m > 1; m = m >> 1)
	{
		j1 = 0;
		h = m >> 1;
		for (i = 0; i < h; i++)
		{
			j2 = j1 + t - 1;
			S = inv_psi[h + i];

			for (j = j1; j <= j2; j++)
			{
				U = a[j];
				V = a[j + t];
				a[j]=fmodq(U + V);
				a[j+t]= fmodq((U - V)*S);

			}
			j1 = j1 + (t << 1);
		}
		t = t << 1;

	}

	for (j = 0; j < N; j++)
	{
		a[j] = fmodq(a[j] * Ninv);
	}

}

/* Key Generation */
int crypto_kem_keypair(unsigned char *pk, unsigned char *sk)
{

	unsigned char rnd_t[CRYPTO_R_n];
	int i;
	int tmp[CRYPTO_R_n], tmp2[CRYPTO_R_n];

	int *pPubKey_A, *pPubKey_B, *pPriKey;

	pPubKey_A = (int*)calloc(CRYPTO_R_n, sizeof(int));
	pPubKey_B = (int*)calloc(CRYPTO_R_n, sizeof(int));
	pPriKey = (int*)calloc(CRYPTO_R_n, sizeof(int));

	randombytes(rnd_t, CRYPTO_R_n);

	/* STEP 1 : Generate a, x, e */
	for (i = 0; i < CRYPTO_R_n; i++)
		pPubKey_A[i] = random_modq();

	for (i = 0; i < CRYPTO_R_n; i++)
		pPriKey[i] = ((rnd_t[i] % 3 + 1) - 2);


	for (i = 0; i < CRYPTO_R_n; i++)
		pPubKey_B[i] = Sample_CDT();

	/* STEP 2 : b = a*x+e */														
	NTT(pPubKey_A, CRYPTO_R_NTT, CRYPTO_R_n);
	NTT(pPriKey, CRYPTO_R_NTT, CRYPTO_R_n);
	NTT(pPubKey_B, CRYPTO_R_NTT, CRYPTO_R_n);
	p_muladd(pPubKey_A, pPriKey, pPubKey_B, pPubKey_B, CRYPTO_R_n);

	_BINT_to_OS(pk, pPubKey_A, CRYPTO_R_n << 2);
	_BINT_to_OS(pk+(CRYPTO_R_n<<2), pPubKey_B, CRYPTO_R_n << 2);
	_BINT_to_OS(sk, pPriKey, CRYPTO_R_n << 2);

	memcpy(sk + (CRYPTO_R_n << 2), pk, CRYPTO_R_n << 3);


	free(pPubKey_A);
	free(pPubKey_B);
	free(pPriKey);

	return 0;

}


/* CPA module for R.CCA */
int _R_KEM_Enc(int *C, unsigned int *delta, int *pPubKey, int *r)
{
	int *m_hat, *e1, *e2;
	int i;
	int tmp1[CRYPTO_R_n], tmp2[CRYPTO_R_n];

	m_hat = (int*)calloc(CRYPTO_R_n, sizeof(int));
	e1 = (int*)calloc(CRYPTO_R_n, sizeof(int));
	e2 = (int*)calloc(CRYPTO_R_n, sizeof(int));

	/* STEP 1 : R_encode */
	for (i = 0; i < CRYPTO_R_msg; i++)
	{

		m_hat[i] ^= 0x2000;
		m_hat[i] ^= ((delta[i >> 5] >> (31 - (i % 32))) & 1) << 14;

	}

	for (i = 0; i < CRYPTO_R_n; i++)
		e1[i] = Sample_CDT();

	for (i = 0; i < CRYPTO_R_n; i++)
		e2[i] = Sample_CDT();


	NTT(r, CRYPTO_R_NTT, CRYPTO_R_n);


	p_mul(pPubKey, r, tmp1, CRYPTO_R_n);
	INTT(tmp1, CRYPTO_R_INTT, CRYPTO_N_INV, CRYPTO_R_n);
	p_add(tmp1, e1, e1, CRYPTO_R_q, CRYPTO_R_n); //Ar+e1

	p_mul(pPubKey+CRYPTO_R_n, r, tmp2, CRYPTO_R_n);
	INTT(tmp2, CRYPTO_R_INTT, CRYPTO_N_INV, CRYPTO_R_n);

	p_add(tmp2, e2, e2, CRYPTO_R_q, CRYPTO_R_n);
	p_add(e2, m_hat, e2, CRYPTO_R_q, CRYPTO_R_n);

	/* STEP 3 : C = C1 || C2 */
	memcpy(C, e1, CRYPTO_R_n * sizeof(int));
	memcpy(C + (CRYPTO_R_n), e2, CRYPTO_R_msg * sizeof(int));

	free(m_hat);
	free(e1);
	free(e2);

	return 0;
}

/* CPA module for R.CCA */
int _R_KEM_dec(unsigned int *delta, int *C, int *pPriKey)
{
	int *d, *m_hat, *C_cpy;
	int i;
	int tmp;

	d = (int*)calloc(CRYPTO_R_n, sizeof(int));
	m_hat = (int*)calloc(CRYPTO_R_n, sizeof(int));
	C_cpy = (int*)calloc(CRYPTO_R_n, sizeof(int));


	NTT_new(C_cpy, C, CRYPTO_R_NTT, CRYPTO_R_n);
	p_mul(C_cpy, pPriKey, d, CRYPTO_R_n);
	INTT(d, CRYPTO_R_INTT, CRYPTO_N_INV, CRYPTO_R_n);

	for (i = 0; i < CRYPTO_R_msg; i++)
	{

		m_hat[i] = (C[i + CRYPTO_R_n] - d[i]) % CRYPTO_R_q;
		if (m_hat[i] < 0) m_hat[i] += CRYPTO_R_q;

	}

	memset(delta, 0, 8 * sizeof(int));

	for (i = 0; i < CRYPTO_R_msg; i++)
	{
		delta[i >> 5] ^= ((m_hat[i] >> 14) & 1) << (31 - (i % 32));
	}

	free(d);
	free(m_hat);
	free(C_cpy);
	return 0;
}

unsigned int _R_KEM_GenTrinary(int *r, unsigned int *delta)
{
	unsigned int d_tmp[8];
	unsigned int tmp[8];
	int cnt = 0;
	int j;

	memcpy(d_tmp, delta, 8 * sizeof(int));
	memset(tmp, 0, 8 * sizeof(int));

	while (cnt < CRYPTO_R_n)
	{
		SHA256_INT(d_tmp, CRYPTO_R_msg >> 3, tmp);
		for (j = 0; j < 8; j++)
		{
			while ((tmp[j] != 0) && (cnt<CRYPTO_R_n))
			{
				r[cnt] = (((tmp[j] % 3) + 1) - 2);
				tmp[j] = tmp[j] / 3;
				cnt++;
			}

		}

		d_tmp[0]++;
		memset(tmp, 0, 8 * sizeof(int));

	}

	// Generate Seed
	memcpy(d_tmp, delta, 8 * sizeof(int));
	SHA256_INT(d_tmp, CRYPTO_R_msg >> 3, tmp);

	return tmp[0];

}


int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk)
{
	unsigned int delta[9], tmp[8];
	unsigned char rnd[32], e_input[48];
	unsigned int seed_in, KLen;
	unsigned int *K_tmp;
	int *pPubKey, *C;
	int *r, *C_KEM;
	int i;

	r = (int*)calloc(CRYPTO_R_n, sizeof(int));
	C_KEM = (int*)calloc(CRYPTO_R_n + CRYPTO_R_msg, sizeof(int));
	K_tmp = (unsigned int*)calloc(CRYPTO_R_n + CRYPTO_R_msg + 16, sizeof(unsigned int));
	pPubKey = (int*)calloc(CRYPTO_R_n<<1, sizeof(int));
	C = (int*)calloc(CRYPTO_R_n + CRYPTO_R_msg + 8, sizeof(int));


	KLen = CRYPTO_R_n + CRYPTO_R_msg + 16;
	KLen = KLen << 2;

	_OS_to_BINT(pPubKey, pk, CRYPTO_R_n<<1);
	
	randombytes(rnd, 32);

	_OS_to_BINT(delta, rnd, 8);


	/* STEP 1 : Generate R */
	seed_in = _R_KEM_GenTrinary(r, delta);

	/* STEP 2 : Generate ciphertext */
	memset(e_input, 0, 48);
	e_input[0] =(seed_in&0xff000000)>>24;
	e_input[1] =(seed_in&0x00ff0000)>>16;
	e_input[2] =(seed_in&0x0000ff00)>>8;
	e_input[3] =(seed_in&0xff);
 
	randombytes_init (e_input, NULL, 256);
	_R_KEM_Enc(C_KEM, delta, pPubKey, r);

	/* STEP 3 : Generate hash */
	delta[8]=0x02000000;
	SHA256_INT(delta, 33, tmp);

	// C = NTT( C1 || C2 )|| C3

	memcpy(C, C_KEM, (CRYPTO_R_n + CRYPTO_R_msg) * sizeof(unsigned int));
	memcpy(C + (CRYPTO_R_n + CRYPTO_R_msg), tmp, 8 * sizeof(unsigned int));

	_BINT_to_OS(ct, C, (CRYPTO_R_n + CRYPTO_R_msg + 8) << 2);

	/* STEP 4 : Generate key */
	memcpy(K_tmp, delta, 8 * sizeof(unsigned int));
	memcpy(K_tmp + 8, C, (CRYPTO_R_n + CRYPTO_R_msg + 8) * sizeof(unsigned int));


	SHA256_OS(K_tmp, KLen, ss);

	free(r);
	free(C_KEM);
	free(K_tmp);
	free(pPubKey);
	free(C);

	return 0;


}


int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk)
{
	unsigned char e_input[48];
	unsigned int delta[9], tmp[8];
	unsigned int seed_in, KLen;
	unsigned int *K_tmp;
	int *C_tmp, *r;
	int *pPubKey, *pPriKey, *C;
	
	int ret;

	C_tmp = (int*)calloc(CRYPTO_R_n + CRYPTO_R_msg, sizeof(int));
	C = (int*)calloc(CRYPTO_R_n + CRYPTO_R_msg+8, sizeof(int));
	r = (int*)calloc(CRYPTO_R_n, sizeof(int));
	K_tmp = (unsigned int*)calloc(CRYPTO_R_n + CRYPTO_R_msg + 16, sizeof(unsigned int));

	pPubKey = (int*)calloc(CRYPTO_R_n<<1, sizeof(int));
	pPriKey = (int*)calloc(CRYPTO_R_n, sizeof(int));

	KLen = CRYPTO_R_n + CRYPTO_R_msg + 16;
	KLen = KLen << 2;

	_OS_to_BINT(pPubKey, sk+(CRYPTO_R_n<<2), CRYPTO_R_n << 1);
	_OS_to_BINT(pPriKey, sk, CRYPTO_R_n);
	_OS_to_BINT(C, ct, CRYPTO_R_n + CRYPTO_R_msg+8);

	/* STEP 1 : Decrypt and obtain delta */
	_R_KEM_dec(delta, C, pPriKey);

	/* STEP 2 : Generate r and seed from delta */
	seed_in = _R_KEM_GenTrinary(r, delta);

	/* STEP 3 : Encrypt */
	memset(e_input, 0, 48);
	e_input[0] =(seed_in&0xff000000)>>24;
	e_input[1] =(seed_in&0x00ff0000)>>16;
	e_input[2] =(seed_in&0x0000ff00)>>8;
	e_input[3] =(seed_in&0xff);
 
	randombytes_init (e_input, NULL, 256);
	_R_KEM_Enc(C_tmp, delta, pPubKey, r);

	delta[8]=0x02000000;
	SHA256_INT(delta, 33, tmp);


	if (memcmp(C_tmp, C, (CRYPTO_R_n + CRYPTO_R_msg) * sizeof(int)) != 0)
	{
		ret = -1;
		goto err;
	}

	if (memcmp(tmp, C + (CRYPTO_R_n + CRYPTO_R_msg), 8 * sizeof(int)) != 0)
	{
		ret = -1;
		goto err;
	}

	/* STEP 4 : Generate key*/
	memcpy(K_tmp, delta, 8 * sizeof(unsigned int));
	memcpy(K_tmp + 8, C, (CRYPTO_R_n + CRYPTO_R_msg + 8) * sizeof(unsigned int));


	SHA256_OS(K_tmp, KLen, ss);


err:

	free(C_tmp);
	free(r);
	free(K_tmp);
	free(pPubKey);
	free(pPriKey);
	free(C);
	return 0;



}
