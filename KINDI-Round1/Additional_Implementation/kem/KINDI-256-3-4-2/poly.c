#include "poly.h"

// initialize a polynomial with zeros
void poly_init(poly_d r) {
	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		r[i] = 0;
}

// convert an polynomial with double coeffs to integer coeffs
void poly_type_convert_fd(poly_d d, poly_f f) {

	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		d[i] = (int64_t) f[i];
}

// convert an polynomial with integer coeffs to double coeffs
void poly_type_convert_df(poly_f f, poly_d d) {

	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		f[i] = (double) d[i];
}

// copy a polynomial
void poly_copy_d(poly_d r, poly_d p) {
	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		r[i] = p[i];
}

// Return random polynomial with uniformly distributed coefficients in [-r_sec,r_sec) with r_sec power of two
void poly_setrandom_rsec(poly_d *r,poly_d *e, uint8_t *gamma) {

	int bufferlen = 2*KINDI_KEM_L*KINDI_KEM_N*(KINDI_KEM_LOG2RSEC+1)/8;
	uint8_t *buffer = malloc(bufferlen);
	kindi_crypto_stream(buffer,bufferlen,gamma,KINDI_KEM_SEEDSIZE);
	int i;
	uint64_t offset =0;
	for(i=0;i<KINDI_KEM_L;i++){

		poly_neg_frombytes_bitlen(r[i],buffer+offset,KINDI_KEM_LOG2RSEC+1);
		offset+= KINDI_KEM_N*(KINDI_KEM_LOG2RSEC+1)/8;
		poly_neg_frombytes_bitlen(e[i],buffer+offset,KINDI_KEM_LOG2RSEC+1);
		offset+= KINDI_KEM_N*(KINDI_KEM_LOG2RSEC+1)/8;
	}

	free(buffer);
}

// generate LxL matrix of polynomials from a seed \mu
void poly_gen_matrix(poly_d **A, uint8_t * seed) {

	uint32_t tmp;
	int buffer_size = KINDI_KEM_L * KINDI_KEM_L * KINDI_KEM_N * KINDI_KEM_BYTESLOGQ;
	uint8_t *buffer = malloc(buffer_size);

	kindi_crypto_stream(buffer, buffer_size, seed, KINDI_KEM_SEEDSIZE);
	int a, x, i, y;
	int pos = 0;
	for (a = 0; a < KINDI_KEM_L; a++)
		for (x = 0; x < KINDI_KEM_L; x++)
			for (i = 0; i < KINDI_KEM_N; i++) {
				tmp = 0;
				for (y = 0; y < KINDI_KEM_BYTESLOGQ; y++)
					tmp += (int) buffer[pos++] << y * 8;

				A[a][x][i] = tmp & (KINDI_KEM_Q - 1);

			}

	free(buffer);
}


// subtract every coefficient with a constant
void poly_sub_constant(poly_d r, const poly_d f, const int64_t c) {
  int i;

  __m256i vf, vc;
  vc = _mm256_set1_epi64x(c);

  for (i = 0; i < KINDI_KEM_N; i += 4) {
    vf = _mm256_load_si256((__m256i  const *) (f + i));
    vf = _mm256_sub_epi64(vf, vc);
    _mm256_store_si256((__m256i *) (r + i), vf);
  }


}

// add two polynomials
void poly_add_nored(poly_d r, const poly_d f, const poly_d g) {
	int i;

	__m256i vf, vg;

	for (i = 0; i < KINDI_KEM_N; i += 4) {
		vf = _mm256_load_si256((__m256i  const *) (f + i));
		vg = _mm256_load_si256((__m256i  const *) (g + i));
		vf = _mm256_add_epi64(vf, vg);
		_mm256_store_si256((__m256i *) (r + i), vf);
	}


}

// subtract two polynomials
void poly_sub_nored(poly_d r, const poly_d f, const poly_d g) {
	int i;

	__m256i vf, vg;

	for (i = 0; i < KINDI_KEM_N; i += 4) {
		vf = _mm256_load_si256((__m256i  const *) (f + i));
		vg = _mm256_load_si256((__m256i  const *) (g + i));
		vf = _mm256_sub_epi64(vf, vg);
		_mm256_store_si256((__m256i *) (r + i), vf);
	}

}

// print integer polynomial on stdout for debugging purposes
void poly_print_d(const char *c, const poly_d f) {
	int i;
	printf("%s=\n", c);
	for (i = 0; i < KINDI_KEM_N; i++)
		printf("%ld, ", f[i]);
	printf("\n\n");
}

// print double polynomial on stdout for debugging purposes
void poly_print_f(const char *c, const poly_f f) {
	int i;
	printf("%s=\n", c);
	for (i = 0; i < KINDI_KEM_N; i++)
		printf("%0.20f, ", f[i]);
	printf("\n\n");
}

// check two polynomials for equality
int poly_equal(const poly_d f, const poly_d g) {
	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		if (f[i] != g[i])
			return -1;

	return 0;
}

// reduce the coefficients of a polynomial mod Q
void poly_coeffreduce(poly_d r) {
	int i;

	for (i = 0; i < KINDI_KEM_N; i++)
		r[i] = r[i] & (KINDI_KEM_Q - 1);

}

// reduce the coefficients of a polynomial mod Q and center them
void poly_coeffreduce_center(poly_d r) {

	int i;

	for (i = 0; i < KINDI_KEM_N; i++) {
		r[i] = r[i] & (KINDI_KEM_Q - 1);
		if (r[i] > (KINDI_KEM_Q - 1) / 2)
			r[i] = r[i] - KINDI_KEM_Q;

		else if (r[i] < -(KINDI_KEM_Q - 1) / 2)
			r[i] = r[i] + KINDI_KEM_Q;
	}

}


extern void fft_transform(poly_f r_real, poly_f r_img, const poly_f o_real,
		const poly_f o_img);

void fft(poly_f out_real, poly_f out_img) {
	fft_transform(out_real, out_img, omegas_real, omegas_img);
}

void inverse_fft(poly_f out_real, poly_f out_img) {
	fft_transform(out_real, out_img, inverse_omegas_real, inverse_omegas_img);
}

// multiply two polynomials
void poly_mul(poly_d r, poly_d x, poly_d y) {
	int i;

	poly_f first_real, first_im, second_real, second_im;
	poly_f result_real, result_im;

	__m256d vx_real, vx_img, vt_real, vt_img, vpsis_real, vpsis_img, temp;
	__m256d temp_ad, temp_bd;

	poly_f x_f, y_f, r_f;
	poly_type_convert_df(x_f, x);
	poly_type_convert_df(y_f, y);

	//psiloop
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(x_f + i);
		vpsis_real = _mm256_loadu_pd(psis_real + i);
		vpsis_img = _mm256_loadu_pd(psis_img + i);
		temp = _mm256_mul_pd(vx_real, vpsis_real);
		_mm256_storeu_pd(first_real + i, temp);
		temp = _mm256_mul_pd(vx_real, vpsis_img);
		_mm256_storeu_pd(first_im + i, temp);

		vx_real = _mm256_loadu_pd(y_f + i);
		temp = _mm256_mul_pd(vx_real, vpsis_real);
		_mm256_storeu_pd(second_real + i, temp);
		temp = _mm256_mul_pd(vx_real, vpsis_img);
		_mm256_storeu_pd(second_im + i, temp);

	}

	fft(first_real, first_im);
	fft(second_real, second_im);

	//pointwise multiplication
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(first_real + i);
		vx_img = _mm256_loadu_pd(first_im + i);
		vt_real = _mm256_loadu_pd(second_real + i);
		vt_img = _mm256_loadu_pd(second_im + i);

		_mm256_mulcmplx_pd(vt_real, vt_img, vt_real, vt_img, vx_real, vx_img);

		_mm256_storeu_pd(result_real + i, vt_real);
		_mm256_storeu_pd(result_im + i, vt_img);
	}

	inverse_fft(result_real, result_im);

	//inverse_psi loop
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(result_real + i);
		vx_img = _mm256_loadu_pd(result_im + i);
		vpsis_real = _mm256_loadu_pd(inverse_psi_n_real + i);
		vpsis_img = _mm256_loadu_pd(inverse_psi_n_img + i);

		//result is real, so no need to calculate imaginary part
		temp = _mm256_mul_pd(vx_real, vpsis_real); //ac
		vx_real = _mm256_mul_pd(vx_img, vpsis_img); //bd
		vx_real = _mm256_sub_pd(temp, vx_real); //ac-bd

		//round
		vx_real = _mm256_round_pd(vx_real, 0x08);
		_mm256_storeu_pd(r_f + i, vx_real);
	}
	poly_type_convert_fd(r, r_f);
	poly_coeffreduce(r);

}

// multiply two polynomials with one polynomial already in FFT domain
void poly_mul_precomp_fft(poly_d r, poly_d x, const poly_f a_real,
		const poly_f a_im) {
	int i;

	poly_f first_real, first_im;
	poly_f result_real, result_im;

	__m256d vx_real, vx_img, vt_real, vt_img, vpsis_real, vpsis_img, temp;
	__m256d temp_ad, temp_bd;
	poly_f x_f, r_f;
	poly_type_convert_df(x_f, x);

	//psiloop
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(x_f + i);
		vpsis_real = _mm256_loadu_pd(psis_real + i);
		vpsis_img = _mm256_loadu_pd(psis_img + i);
		temp = _mm256_mul_pd(vx_real, vpsis_real);
		_mm256_storeu_pd(first_real + i, temp);
		temp = _mm256_mul_pd(vx_real, vpsis_img);
		_mm256_storeu_pd(first_im + i, temp);

	}

	fft(first_real, first_im);

	//pointwise multiplication
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(first_real + i);
		vx_img = _mm256_loadu_pd(first_im + i);
		vt_real = _mm256_loadu_pd(a_real + i);
		vt_img = _mm256_loadu_pd(a_im + i);

		_mm256_mulcmplx_pd(vt_real, vt_img, vt_real, vt_img, vx_real, vx_img);

		_mm256_storeu_pd(result_real + i, vt_real);
		_mm256_storeu_pd(result_im + i, vt_img);
	}

	inverse_fft(result_real, result_im);

	//inverse_psi loop
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(result_real + i);
		vx_img = _mm256_loadu_pd(result_im + i);
		vpsis_real = _mm256_loadu_pd(inverse_psi_n_real + i);
		vpsis_img = _mm256_loadu_pd(inverse_psi_n_img + i);

		//result is real, so no need to calculate imaginary part
		temp = _mm256_mul_pd(vx_real, vpsis_real); //ac
		vx_real = _mm256_mul_pd(vx_img, vpsis_img); //bd
		vx_real = _mm256_sub_pd(temp, vx_real); //ac-bd

		//round
		vx_real = _mm256_round_pd(vx_real, 0x08);
		_mm256_storeu_pd(r_f + i, vx_real);
	}

	poly_type_convert_fd(r, r_f);
	poly_coeffreduce(r);
}

// calculate the FFT of a polynomial, store Re{} and Im{} of result separately
void psi_loop_and_fft(poly_d p, poly_f real, poly_f img) {

	int i;

	__m256d vx_real, vpsis_real, vpsis_img, temp;
	poly_f p_f;
	poly_type_convert_df(p_f, p);

	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(p_f + i);
		vpsis_real = _mm256_loadu_pd(psis_real + i);
		vpsis_img = _mm256_loadu_pd(psis_img + i);
		temp = _mm256_mul_pd(vx_real, vpsis_real);
		_mm256_storeu_pd(real + i, temp);
		temp = _mm256_mul_pd(vx_real, vpsis_img);
		_mm256_storeu_pd(img + i, temp);

	}
	fft(real, img);
}

// multiply two polynomials with both polynomials already in FFT domain
void poly_mul_pointwise(poly_d r, poly_f a_real, poly_f a_im, poly_f b_real,
		poly_f b_im) {

	int i;

	poly_f result_real, result_im;

	__m256d vx_real, vx_img, vt_real, vt_img, vpsis_real, vpsis_img, temp;
	__m256d temp_ad, temp_bd;

	poly_f r_f;

	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(a_real + i);
		vx_img = _mm256_loadu_pd(a_im + i);
		vt_real = _mm256_loadu_pd(b_real + i);
		vt_img = _mm256_loadu_pd(b_im + i);

		_mm256_mulcmplx_pd(vt_real, vt_img, vt_real, vt_img, vx_real, vx_img);

		_mm256_storeu_pd(result_real + i, vt_real);
		_mm256_storeu_pd(result_im + i, vt_img);
	}

	inverse_fft(result_real, result_im);

	//inverse_psi loop
	for (i = 0; i < KINDI_KEM_N; i += 4) {

		vx_real = _mm256_loadu_pd(result_real + i);
		vx_img = _mm256_loadu_pd(result_im + i);
		vpsis_real = _mm256_loadu_pd(inverse_psi_n_real + i);
		vpsis_img = _mm256_loadu_pd(inverse_psi_n_img + i);

		//result is real, so no need to calculate imaginary part
		temp = _mm256_mul_pd(vx_real, vpsis_real); //ac
		vx_real = _mm256_mul_pd(vx_img, vpsis_img); //bd
		vx_real = _mm256_sub_pd(temp, vx_real); //ac-bd

		//round
		vx_real = _mm256_round_pd(vx_real, 0x08);
		_mm256_storeu_pd(r_f + i, vx_real);
	}

	poly_type_convert_fd(r, r_f);
	poly_coeffreduce(r);
}

// truncate the t least significant bits of each coefficient
void poly_compress(poly_d p, const int t) {

	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		p[i] >>= t;
}

// append t least significant 0s to each coefficient
void poly_decompress(poly_d p, const int t) {

	int i;
	for (i = 0; i < KINDI_KEM_N; i++)
		p[i] <<= t;

}

