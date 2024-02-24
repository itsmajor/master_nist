#include "poly.h"

static void bitrev(poly_f r) {
	double t;
#if KINDI_KEM_N == 256
#include "data_fft/bitrev256.code"
#endif
#if KINDI_KEM_N == 512
#include "data_fft/bitrev512.code"
#endif
}

void fft_transform(poly_f out_real, poly_f out_img, const poly_f o_real,
		const poly_f o_img) {

	int s, m, i;

	bitrev(out_real);
	bitrev(out_img);

	int offset;
	__m256d vo1_real, vx0_real, vx1_real, vt_real;
	__m256d vo1_img, vx0_img, vx1_img, vt_img;
	__m256d neg2, neg4;
	__m256d temp_ad, temp_bd;

	vo1_real = _mm256_load_pd(o_real);
	vo1_img = _mm256_load_pd(o_img);

	neg2 = _mm256_load_pd(_neg2);
	neg4 = _mm256_load_pd(_neg4);

	//m=2, m=4 (2 levels merged)
	for (offset = 0; offset < KINDI_KEM_N; offset += 4) {

		//### level 0 (m=2)###
		vx0_real = _mm256_load_pd(out_real + offset);
		vx0_img = _mm256_load_pd(out_img + offset);
		vt_real = _mm256_mul_pd(vx0_real, neg2);
		vt_img = _mm256_mul_pd(vx0_img, neg2);
		vx0_real = _mm256_hadd_pd(vx0_real, vt_real);
		vx0_img = _mm256_hadd_pd(vx0_img, vt_img);

		//### level 1 (m=4)###
		_mm256_mulcmplx_pd(vx0_real, vx0_img, vx0_real, vx0_img, vo1_real,
				vo1_img);
		vt_real = _mm256_permute2f128_pd(vx0_real, vx0_real, 0x01);
		vt_img = _mm256_permute2f128_pd(vx0_img, vx0_img, 0x01);
		vx0_real = _mm256_mul_pd(vx0_real, neg4);
		vx0_img = _mm256_mul_pd(vx0_img, neg4);
		vx0_real = _mm256_add_pd(vx0_real, vt_real);
		vx0_img = _mm256_add_pd(vx0_img, vt_img);

		_mm256_store_pd(out_real + offset, vx0_real);
		_mm256_store_pd(out_img + offset, vx0_img);
	}

	//m=8, m=16,..., m=POLY_DEG
	for (m = 8; m <= KINDI_KEM_N; m = m * 2) {

		for (s = 0; s < KINDI_KEM_N; s += m) {

			for (i = 0; i < (m / 2); i += 4) {

				vo1_real = _mm256_load_pd(o_real + i + (m / 2));
				vo1_img = _mm256_load_pd(o_img + i + (m / 2));
				vx0_real = _mm256_load_pd(out_real + s + i);
				vx0_img = _mm256_load_pd(out_img + s + i);
				vx1_real = _mm256_load_pd(out_real + s + i + (m / 2));
				vx1_img = _mm256_load_pd(out_img + s + i + (m / 2));
				_mm256_mulcmplx_pd(vt_real, vt_img, vx1_real, vx1_img, vo1_real,
						vo1_img);

				vx1_real = _mm256_sub_pd(vx0_real, vt_real); //butterfly - (real)
				vx1_img = _mm256_sub_pd(vx0_img, vt_img); //butterfly - (img)
				vx0_real = _mm256_add_pd(vx0_real, vt_real); //butterfly + (real)
				vx0_img = _mm256_add_pd(vx0_img, vt_img); //butterfly + (img)

				_mm256_store_pd(out_real + s + i, vx0_real);
				_mm256_store_pd(out_img + s + i, vx0_img);

				_mm256_store_pd(out_real + s + i + (m / 2), vx1_real);
				_mm256_store_pd(out_img + s + i + (m / 2), vx1_img);

			}
		}
	}
}
