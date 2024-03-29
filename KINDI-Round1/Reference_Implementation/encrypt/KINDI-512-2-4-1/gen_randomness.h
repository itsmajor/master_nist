#ifndef SAMPLE_SU_H
#define SAMPLE_SU_H

#include <string.h>
#include <stdlib.h>


#include "params.h"
#include "fips202.h"
#include "poly.h"
#include "util.h"


void fastrandombytes(unsigned char *r, unsigned long long rlen);

void kindi_crypto_stream(uint8_t *out, unsigned long long outlen,
		const uint8_t *in, unsigned long long inlen);

void kindi_crypto_stream_2(uint8_t *out, uint8_t *in);

void gen_randomness(poly_d *s, uint8_t *u, uint8_t *s1);

#endif
