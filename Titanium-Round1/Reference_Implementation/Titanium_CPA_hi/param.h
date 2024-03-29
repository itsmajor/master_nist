/* ****************************** *
 * Titanium_CPA_hi                *
 * Implemented by Raymond K. ZHAO *
 *                                *
 * Parameters                     *
 * ****************************** */
 
#ifndef PARAM_H
#define PARAM_H

#define CRYPTO_RANDOMBYTES 32

#define Q 737281
#define Q2 (Q << 1) /* Q*2 */
#define Q_BITS 20 /* 20 bits for a number in Z_q */

#define ZQ_BYTES 3 /* 3 random bytes to sample a number in Z_q */
#define LOAD_ZQ load_24

/* the actual number of random coordinates generated by sampler_zq */
#define ZQ_BYTPCS 2857
#define ZQ_BYTPCA 1760

#define N 1536

#define K 767

#define D 256
#define D_BYTES 32 /* 256 --> 32 bytes */

/* function names of the NTTs */
#define INTT_NDK_NDK intt_2560_2560
#define INTT_DK_DK intt_1024_1024
#define NTT_NK_NK ntt_2304_2304
#define INTT_NK_NK_INV intt_2304_2304_inv
#define NTT_DK_DK_INV ntt_1024_1024_inv

#define T 7

/* the standard deviation of binomial sampler is sqrt(k/2)=1.41 */
#define BINOMIAL_K 4
#define BINOMIAL_BYTE 1
#define BINOMIAL_ADDMASK 0x11
#define BINOMIAL_MASK 0x0f
#define BINOMIAL_SHIFT 4
#define LOAD_BINOMIAL load_8

/* B_1/2=256 and B_2/2=512 */
#define B_1_BIT 8 /* 2^8=256 */
#define B_1_BITMASK ((1 << B_1_BIT) - 1)

#define B_2_BIT 9 /* 2^9=512 */
#define B_2_BITMASK ((1 << B_2_BIT) - 1)

#define NUM_B1 3384 /* Ndec1 */

#define B_BYTE 2 /* 2 random bytes to sample a number in Z_B */
#define LOAD_B load_16

/* c_2 compression bit number
 * discard the least significant 12 bits to make each c_2 coordinate fit in one byte */
#define C2_COMPRESSION_BITS 12
#define C2_COMPRESSION_BYTE 1
#define LOAD_C2 load_8
#define STORE_C2 store_8

#endif
