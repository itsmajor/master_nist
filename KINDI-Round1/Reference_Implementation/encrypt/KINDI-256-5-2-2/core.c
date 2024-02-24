#include "core.h"

void xor_bytes(uint8_t *r, const uint8_t *f, const uint8_t *g, int len) {

	int i;
	for (i = 0; i < len; i++)
		r[i] = f[i] ^ g[i];
}

void recover_s1(uint8_t *s1, poly_d v) {

#if KINDI_CPA_S1BITS == 1
#define LOWER_BOUND (KINDI_CPA_Q/4)
#define UPPER_BOUND (3*KINDI_CPA_Q/4)
	int i, a, pos = 0;

	memset(s1, 0, KINDI_CPA_S1SIZE);
	for (i = 0; i < KINDI_CPA_S1SIZE; i++) {
		for (a = 0; a < 8; a++) {

			  s1[i] |= (lround((float)v[pos++]/(KINDI_CPA_Q/2)) & 1) << a;
		}
	}
#elif KINDI_CPA_S1BITS == 2
	int i, a, pos = 0;

	memset(s1, 0, KINDI_CPA_S1SIZE);
	for (i = 0; i < KINDI_CPA_S1SIZE; i++) {
		for (a = 0; a < 4; a++) {

			s1[i] |= (lround((float)v[pos++]/(KINDI_CPA_Q/4)) & 0x03) << (2*a);
		}
	}


#endif
}

void kindi_cpa_keygen(kindi_pk *pk, poly_d *sk_r) {

	int i, x;
	poly_d **A, *e, tmp;

	A = (poly_d**) malloc( KINDI_CPA_L * sizeof(poly_d*));
	e = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));
	for (i = 0; i < KINDI_CPA_L; i++)
		A[i] = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));

	// \mu
	randombytes(pk->seed, KINDI_CPA_SEEDSIZE);

	// A \in R_q^{lxl} <- SampleU(\mu)
	poly_gen_matrix(A, pk->seed);

	// sample r,e with coefficients in [-r_sec,r_sec)
	uint8_t *gamma = malloc(KINDI_CPA_SEEDSIZE);
	randombytes(gamma,KINDI_CPA_SEEDSIZE);
	poly_setrandom_rsec(sk_r,e,gamma);
	free(gamma);

	//cache FFT of sk to avoid redundant FFT calculations in poly_mul
	poly_f *r_real, *r_imag;
	r_real = (poly_f*) malloc( KINDI_CPA_L * sizeof(poly_f));
	r_imag = (poly_f*) malloc( KINDI_CPA_L * sizeof(poly_f));
	for (i = 0; i < KINDI_CPA_L; i++)
		psi_loop_and_fft(sk_r[i], r_real[i], r_imag[i]);

	// b = A*r + e
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_init(pk->b[i]);
		for (x = 0; x < KINDI_CPA_L; x++) {

			poly_mul_precomp_fft(tmp, A[i][x], r_real[x], r_imag[x]);
			poly_add_nored(pk->b[i], pk->b[i], tmp);
		}
		poly_add_nored(pk->b[i], pk->b[i], e[i]);
		poly_coeffreduce_pos(pk->b[i]);
	}

	for (i = 0; i < KINDI_CPA_L; i++)
		free(A[i]);
	free(A);
	free(r_real);
	free(r_imag);
	free(e);

}

void kindi_cpa_encrypt(kindi_pk *pk, const uint8_t *message_in,
		const unsigned long long mlen, poly_d *cipher) {

	int i, x;

	poly_d *s, **A, *u_encoded, tmp;
	s = (poly_d *) malloc( KINDI_CPA_L * sizeof(poly_d));
	u_encoded = (poly_d*) malloc( (KINDI_CPA_L + 1) * sizeof(poly_d));
	A = (poly_d**) malloc( KINDI_CPA_L * sizeof(poly_d*));
	for (i = 0; i < KINDI_CPA_L; i++)
		A[i] = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));

	poly_f *s_real, *s_imag;
	s_real = (poly_f*) malloc( KINDI_CPA_L * sizeof(poly_f));
	s_imag = (poly_f*) malloc( KINDI_CPA_L * sizeof(poly_f));

	uint8_t *u, *s1, *message_padded;
	u = malloc(KINDI_CPA_MESSAGESIZE + 1);
	s1 = malloc(KINDI_CPA_S1SIZE);
	message_padded = calloc(KINDI_CPA_MESSAGESIZE + 1, 1);

	//padding with 0
	memcpy(message_padded, message_in, mlen);
	message_padded[mlen] = 0x80; //mark end;

	// s1
	randombytes(s1, KINDI_CPA_S1SIZE);

	// u_bar,s_1_bar,(s_2,...,s_l) <- G(s1)
	gen_randomness(s, u, s1);

	// u = u_bar XOR msg
	xor_bytes(u, u, message_padded, KINDI_CPA_MESSAGESIZE + 1);

	// u_encoded = e = Encode(u) - r_sec;
	for (x = 0; x < KINDI_CPA_L + 1; x++) {
		poly_frombytes_bitlen(u_encoded[x],
				u + x * (KINDI_CPA_N * (KINDI_CPA_LOG2RSEC + 1) / 8),
				KINDI_CPA_LOG2RSEC + 1);
		for (i = 0; i < KINDI_CPA_N; i++) {
			u_encoded[x][i] -= KINDI_CPA_RSEC;
		}
	}


	//cache FFT of s_i to avoid redundant FFT calculations in poly_mul
	for (i = 0; i < KINDI_CPA_L; i++)
		psi_loop_and_fft(s[i], s_real[i], s_imag[i]);

	// A <- SampleU(\mu)
	poly_gen_matrix(A, pk->seed);

	// (c_1,c_2,...,c_L)
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_init(cipher[i]);
		for (x = 0; x < KINDI_CPA_L; x++) {
			// A^t * s
			poly_mul_precomp_fft(tmp, A[x][i], s_real[x], s_imag[x]);
			poly_add_nored(cipher[i], cipher[i], tmp);
		}

		// A^t*s + e
		poly_add_nored(cipher[i], cipher[i], u_encoded[i]);
		//poly_print_d("cipher_i",cipher[i]);
		poly_coeffreduce_pos(cipher[i]);
	}

	// c_{L2+1} = (b_1-g_{k-1},b_2,...,b_L)*s + e_{L+1}
#if KINDI_CPA_S1BITS == 1
	pk->b[0][0] += (1 << (KINDI_CPA_LOGQ - 1));
#elif KINDI_CPA_S1BITS == 2
	pk->b[0][0] += (1 << (KINDI_CPA_LOGQ - 2));
#endif
	poly_init(cipher[KINDI_CPA_L]);
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_mul_precomp_fft(tmp, pk->b[i], s_real[i], s_imag[i]);
		poly_add_nored(cipher[KINDI_CPA_L], cipher[KINDI_CPA_L], tmp);
	}
#if KINDI_CPA_S1BITS == 2
	poly_sub_constant(cipher[KINDI_CPA_L], cipher[KINDI_CPA_L],(1 << (KINDI_CPA_LOGQ-2))*KINDI_CPA_RSEC);
#endif
	poly_add_nored(cipher[KINDI_CPA_L], cipher[KINDI_CPA_L],
			u_encoded[KINDI_CPA_L]);

	poly_coeffreduce_pos(cipher[KINDI_CPA_L]);

	free(s1);
	free(s);
	for (i = 0; i < KINDI_CPA_L; i++)
		free(A[i]);
	free(A);
	free(u);
	free(u_encoded);
	free(s_real);
	free(s_imag);
	free(message_padded);
}

void kindi_cpa_decrypt(poly_d *sk_r, kindi_pk *pk, poly_d *cipher,
		uint8_t *message_out, unsigned long long *mlen) {

	int i, x;

	poly_d *u_rec, *s_rec, **A, v, tmp;
	u_rec = (poly_d *) malloc( (KINDI_CPA_L + 1) * sizeof(poly_d));
	s_rec = (poly_d *) malloc( KINDI_CPA_L * sizeof(poly_d));
	A = (poly_d**) malloc( KINDI_CPA_L * sizeof(poly_d *));
	for (i = 0; i < KINDI_CPA_L; i++)
		A[i] = (poly_d*) malloc( KINDI_CPA_L * sizeof(poly_d));

	poly_f *s_rec_real, *s_rec_imag;
	s_rec_real = (poly_f*) malloc( KINDI_CPA_L * sizeof(poly_f));
	s_rec_imag = (poly_f*) malloc( KINDI_CPA_L * sizeof(poly_f));

	uint8_t *s1, *u_bar, *u_rec_bytes, *message_padded;

	s1 = malloc(KINDI_CPA_S1SIZE);

	u_bar = malloc(KINDI_CPA_MESSAGESIZE + 1);
	u_rec_bytes = malloc(KINDI_CPA_MESSAGESIZE + 1);
	message_padded = malloc(KINDI_CPA_MESSAGESIZE + 1);

	// A <- gen_matrix(\mu)
	poly_gen_matrix(A, pk->seed);

	// v = c_{L+1} - (c1,...,c_L)*r = g_{k-1}*s + small
	poly_init(v);
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_mul(tmp, cipher[i], sk_r[i]);
		poly_add_nored(v, v, tmp);
	}
	poly_sub_nored(v, cipher[KINDI_CPA_L], v);
	poly_coeffreduce_pos(v);

	// s1 = Recover(v)
	recover_s1(s1, v);

	// u_bar,s_1_bar,(s_2,...,s_l) <- G(s1)
	gen_randomness(s_rec, u_bar, s1);

	//cache FFT of s_i to avoid redundant FFT calculations in poly_mul
	for (i = 0; i < KINDI_CPA_L; i++)
		psi_loop_and_fft(s_rec[i], s_rec_real[i], s_rec_imag[i]);

	// (u_1,u_2,...,u_L) = cipher - A^t * s
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_init(u_rec[i]);
		for (x = 0; x < KINDI_CPA_L; x++) {
			//A^t * s
			poly_mul_precomp_fft(tmp, A[x][i], s_rec_real[x], s_rec_imag[x]);
			poly_add_nored(u_rec[i], u_rec[i], tmp);
		}
		poly_sub_nored(u_rec[i], cipher[i], u_rec[i]);
		poly_coeffreduce_center(u_rec[i]);
	}

	// u_{L+1} = cipher_{L+1} - b * s
#if KINDI_CPA_S1BITS == 1
	pk->b[0][0] += (1 << (KINDI_CPA_LOGQ - 1));
#elif KINDI_CPA_S1BITS == 2
	pk->b[0][0] += (1 << (KINDI_CPA_LOGQ - 2));
#endif
	poly_init(u_rec[KINDI_CPA_L]);
	for (i = 0; i < KINDI_CPA_L; i++) {
		poly_mul_precomp_fft(tmp, pk->b[i], s_rec_real[i], s_rec_imag[i]);
		poly_add_nored(u_rec[KINDI_CPA_L], u_rec[KINDI_CPA_L], tmp);
	}

	poly_sub_nored(u_rec[KINDI_CPA_L], cipher[KINDI_CPA_L], u_rec[KINDI_CPA_L]);
	poly_coeffreduce_center(u_rec[KINDI_CPA_L]);

	// Decode(u)
	for (x = 0; x < KINDI_CPA_L + 1; x++) {

		for (i = 0; i < KINDI_CPA_N; i++) {
			u_rec[x][i] += KINDI_CPA_RSEC;
		}
		poly_tobytes_bitlen(
				u_rec_bytes + x * (KINDI_CPA_N * (KINDI_CPA_LOG2RSEC + 1) / 8),
				u_rec[x],
				KINDI_CPA_LOG2RSEC + 1);
	}

	// msg = Decode(u) XOR u_bar
	xor_bytes(message_padded, u_rec_bytes, u_bar, KINDI_CPA_MESSAGESIZE + 1);

	// remove padding
	int index = KINDI_CPA_MESSAGESIZE;
	while (message_padded[index] != 0x80)
		--index;
	*mlen = index;

	memcpy(message_out, message_padded, index);

	free(s1);
	free(s_rec);
	free(u_bar);
	free(u_rec);
	free(u_rec_bytes);
	for (i = 0; i < KINDI_CPA_L; i++)
		free(A[i]);
	free(A);
	free(s_rec_real);
	free(s_rec_imag);
	free(message_padded);
}

