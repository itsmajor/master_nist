#include "params.h"
#include "core.h"

int crypto_encrypt_keypair(unsigned char *pk, unsigned char *sk) {

	int i;
	memset(sk, 0, KINDI_CPA_SECRETKEYBYTES);
	memset(pk, 0, KINDI_CPA_PUBLICKEYBYTES);
	kindi_pk pk_p;
	poly_d *sk_p;

	pk_p.b = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));
	pk_p.seed = (uint8_t *) malloc(KINDI_CPA_SEEDSIZE);
	sk_p = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));
	kindi_cpa_keygen(&pk_p, sk_p);

	int offset_pk = 0;
	int offset_sk = 0;

	// compress pk and convert to byte-array
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_compress(pk_p.b[i], KINDI_CPA_T); // b_bar = Compress(b,t)
		poly_tobytes_bitlen(pk + offset_pk, pk_p.b[i], KINDI_CPA_LOGQ - KINDI_CPA_T);
		offset_pk += KINDI_CPA_PK_POLYBYTES;
	}

	memcpy(pk + offset_pk, pk_p.seed, KINDI_CPA_SEEDSIZE);

	// convert sk to byte-array
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_neg_tobytes_bitlen(sk + offset_sk, sk_p[i],
				KINDI_CPA_SK_COEFFICIENTBITS);
		offset_sk += KINDI_CPA_SK_POLYBYTES;
	}

	memcpy(sk + offset_sk, pk, KINDI_CPA_PUBLICKEYBYTES);

	free(pk_p.b);
	free(pk_p.seed);
	free(sk_p);
	return 0;
}
int crypto_encrypt(unsigned char * c, unsigned long long * clen,
		const unsigned char * m, unsigned long long mlen,
		const unsigned char * pk) {

	int i;
	kindi_pk pk_p;
	poly_d *cipher = (poly_d *) malloc(
	KINDI_CPA_NUMBER_CIPHERPOLY * sizeof(poly_d));
	pk_p.b = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));
	pk_p.seed = malloc(KINDI_CPA_SEEDSIZE);

	// convert pk from byte-array to polynomials and decompress
	int offset_pk = 0;
	for (i = 0; i < KINDI_CPA_L; i++) {

		poly_frombytes_bitlen(pk_p.b[i], pk + offset_pk, KINDI_CPA_LOGQ - KINDI_CPA_T);
		poly_decompress(pk_p.b[i], KINDI_CPA_T); //p_bar = Decompress(b_bar,t)
		offset_pk += KINDI_CPA_PK_POLYBYTES;
	}

	memcpy(pk_p.seed, pk + offset_pk, KINDI_CPA_SEEDSIZE); // \mu

	kindi_cpa_encrypt(&pk_p, m, mlen, cipher);

	// convert ciphertext to byte-array
	int offset_c = 0;
	for (i = 0; i < KINDI_CPA_NUMBER_CIPHERPOLY; i++) {

		poly_tobytes_bitlen(c + offset_c, cipher[i], KINDI_CPA_LOGQ);
		offset_c += KINDI_CPA_CIPHER_POLYBYTES;
	}
	*clen = KINDI_CPA_CIPHERBYTES;

	free(pk_p.b);
	free(pk_p.seed);
	free(cipher);

	return 0;
}

int crypto_encrypt_open(unsigned char *m, unsigned long long *mlen,
		const unsigned char *c, unsigned long long clen,
		const unsigned char *sk) {

	int i;
	kindi_pk pk_p;

	poly_d *cipher = (poly_d *) malloc(
	KINDI_CPA_NUMBER_CIPHERPOLY * sizeof(poly_d));
	pk_p.b = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));
	pk_p.seed = (uint8_t *) malloc(KINDI_CPA_SEEDSIZE);
	poly_d *sk_p = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));

	int offset_sk = 0;
	int offset_c = 0;

	// convert sk from byte-array to polynomials
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_neg_frombytes_bitlen(sk_p[i], sk + offset_sk,
				KINDI_CPA_SK_COEFFICIENTBITS);
		offset_sk += KINDI_CPA_SK_POLYBYTES;
	}

	// convert pk from byte-array to polynomials and decompress
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_frombytes_bitlen(pk_p.b[i], sk + offset_sk, KINDI_CPA_LOGQ - KINDI_CPA_T);
		poly_decompress(pk_p.b[i], KINDI_CPA_T);
		offset_sk += KINDI_CPA_PK_POLYBYTES;
	}

	memcpy(pk_p.seed, sk + offset_sk, KINDI_CPA_SEEDSIZE); // \mu

	// convert ciphertext from byte-array to polynomials
	for (i = 0; i < KINDI_CPA_NUMBER_CIPHERPOLY; i++) {
		poly_frombytes_bitlen(cipher[i], c + offset_c, KINDI_CPA_LOGQ);
		offset_c += KINDI_CPA_CIPHER_POLYBYTES;
	}

	kindi_cpa_decrypt(sk_p, &pk_p, cipher, m, mlen);

	free(pk_p.b);
	free(pk_p.seed);
	free(sk_p);
	free(cipher);
	return 0;
}
