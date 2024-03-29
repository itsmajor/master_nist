/* ****************************** *
 * Titanium_CPA_std               *
 * Implemented by Raymond K. ZHAO *
 *                                *
 * CPA Encryption                 *
 * ****************************** */

#ifndef ENCRYPT_H
#define ENCRYPT_H

int crypto_encrypt_keypair(
unsigned char *pk,
unsigned char *sk
);

int crypto_encrypt(
unsigned char *c, unsigned long long *clen,
const unsigned char *m, unsigned long long mlen,
const unsigned char *pk
);

int crypto_encrypt_open(
unsigned char *m, unsigned long long *mlen,
const unsigned char *c, unsigned long long clen,
const unsigned char *sk
);

#endif
