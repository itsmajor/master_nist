#define CRYPTO_SECRETKEYBYTES 2254
#define CRYPTO_PUBLICKEYBYTES 1505
#define CRYPTO_CIPHERTEXTBYTES 1349
#define CRYPTO_BYTES 32
#define CRYPTO_ALGNAME "sntrup953"

#include "crypto_kem_sntrup953.h"

#define crypto_kem_keypair crypto_kem_sntrup953_keypair
#define crypto_kem_enc crypto_kem_sntrup953_enc
#define crypto_kem_dec crypto_kem_sntrup953_dec
#define crypto_kem_PUBLICKEYBYTES crypto_kem_sntrup953_PUBLICKEYBYTES
#define crypto_kem_SECRETKEYBYTES crypto_kem_sntrup953_SECRETKEYBYTES
#define crypto_kem_BYTES crypto_kem_sntrup953_BYTES
#define crypto_kem_CIPHERTEXTBYTES crypto_kem_sntrup953_CIPHERTEXTBYTES
#define crypto_kem_PRIMITIVE "sntrup953"