#include <string.h> /* for memcpy */

#include "api.h"
#include "rng.h"
#include "threebears.h"

int crypto_kem_keypair(
    unsigned char *pk,
    unsigned char *sk
) {
    randombytes(sk,BABYBEAR_KEYGEN_SEED_BYTES);
    BabyBear_get_pubkey(pk,sk);
    return 0;
}

int crypto_kem_enc(
    unsigned char *ct,
    unsigned char *ss,
    const unsigned char *pk
) {
    unsigned char seed[BABYBEAR_ENC_SEED_AND_IV_BYTES];
    randombytes(seed,sizeof(seed));
    BabyBear_encapsulate(ss,ct,pk,seed);
    secure_bzero(seed,sizeof(seed));
    return 0;   
}

int crypto_kem_dec(
    unsigned char *ss,
    const unsigned char *ct,
    const unsigned char *sk
) {
    return BabyBear_decapsulate(ss,ct,sk);
}

