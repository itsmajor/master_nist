#ifndef API_H
#define API_H

#include "parameter.h"

#define CRYPTO_SECRETKEYBYTES 		SECRETKEY_BYTES
#define CRYPTO_PUBLICKEYBYTES 		PUBLICKEY_BYTES
#define CRYPTO_BYTES 			(C1_BYTES + MLWE_N/8 +16)


#define CRYPTO_ALGNAME "AKCN-MLWE-CCA"


// Algorithm 32 in the document
int crypto_encrypt_keypair(
		unsigned char *pk,
		unsigned char *sk);

// Algorithm 33 in the document
int crypto_encrypt(
		unsigned char * c, 
		unsigned long long * clen, 
		const unsigned char * m, 
		unsigned long long mlen, 
		const unsigned char * pk);

// Algorithm 34 in the document
int crypto_encrypt_open(
		unsigned char * m, 
		unsigned long long * mlen,
		const unsigned char * c, 
		unsigned long long clen,
		const unsigned char * sk);
		
#endif
