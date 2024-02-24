#pragma once

#include <stdlib.h>
#include <stdio.h>
#include <string.h>


#define CRYPTO_R_n 512
#define CRYPTO_R_k 1
#define CRYPTO_R_logq 16
#define CRYPTO_R_sigma 25
#define CRYPTO_R_t 1
#define CRYPTO_R_NTT ntt_512_40961
#define CRYPTO_R_INTT inv_ntt_512_40961
#define CRYPTO_R_q 40961
#define CRYPTO_R_msg 256
#define CRYPTO_N_INV 40881


typedef struct
{
	int *A;
	int *B;

}_CRYPTO_R_pub_struct;

typedef _CRYPTO_R_pub_struct CRYPTO_R_pub_t[1];