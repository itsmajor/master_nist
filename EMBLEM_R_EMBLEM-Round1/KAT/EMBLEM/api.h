
#ifndef api_h
#define api_h


#define CRYPTO_SECRETKEYBYTES 2039180
#define CRYPTO_PUBLICKEYBYTES 2036736
#define CRYPTO_BYTES 32
#define CRYPTO_CIPHERTEXTBYTES 78368


#define CRYPTO_ALGNAME "EMBLEM"

int crypto_kem_keypair(unsigned char *pk, unsigned char *sk);
int crypto_kem_enc(unsigned char *ct, unsigned char *ss, const unsigned char *pk);
int crypto_kem_dec(unsigned char *ss, const unsigned char *ct, const unsigned char *sk);


#endif
