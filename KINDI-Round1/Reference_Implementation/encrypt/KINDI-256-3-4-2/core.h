#ifndef __CORE_H
#define __CORE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "params.h"
#include "poly.h"
#include "util.h"
#include "fips202.h"
#include "gen_randomness.h"

typedef struct {

	poly_d *b;
	uint8_t *seed;

} kindi_pk;

void xor_bytes(uint8_t *r, const uint8_t *f, const uint8_t *g, int len);
void recover_s1(uint8_t *s1, poly_d v);

void kindi_cpa_keygen(kindi_pk *pk, poly_d *sk);
void kindi_cpa_encrypt(kindi_pk *pk, const uint8_t *message_in,
		const unsigned long long mlen, poly_d *cipher);
void kindi_cpa_decrypt(poly_d *sk_r, kindi_pk *pk, poly_d *cipher,
		uint8_t *message_out, unsigned long long *mlen);

#endif

