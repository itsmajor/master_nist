
#ifndef POLYNOMIAL_H
#define POLYNOMIAL_H

#include "parameter.h"
#include "reduce.h"
 
typedef struct{
	unsigned int coefficients[MLWE_N];
} Polynomial;


void Get_small_poly(Polynomial * ptr, const unsigned char noise_seed[], const unsigned int nonce); 


void Poly_multiply(Polynomial * product, const Polynomial * poly_a, const Polynomial *poly_b);
void Poly_pre_NTT_computation(Polynomial * ptr);
void Poly_NTT_transform(Polynomial * ptr, const int direction);
void Poly_post_NTT_computation(Polynomial * ptr);
void Poly_NTT_componentwise_multiply(Polynomial * product, const Polynomial * a, const Polynomial * b);
void Butterfly(unsigned int * X, unsigned int * Y, unsigned int index);


void Poly_add_then_truncate(Polynomial *sum, const Polynomial *a, unsigned int t);


void Poly_AKCN_Con(
		unsigned int signal[MLWE_N],
		const Polynomial *ptr,
		const unsigned int key[MLWE_N]);
void Poly_AKCN_Rec(unsigned int key[MLWE_N], const Polynomial *sigma, const unsigned int signal[MLWE_N]);


void Poly_truncate(Polynomial * ptr);
void Poly_detruncate(Polynomial * ptr);


#endif
