#ifndef _CONFIG_PKI_H
#define _CONFIG_PKI_H

#include "config_HFE.h"
#include "types_PKI.h"

/* IRREDUCTIBLE POLYNOMIALS WITH NTL
2[1 1 1]
3[1 1 0 1]
4[1 1 0 0 1]
5[1 0 1 0 0 1]
6[1 1 0 0 0 0 1]
7[1 1 0 0 0 0 0 1]
8[1 1 0 1 1 0 0 0 1]
9[1 1 0 0 0 0 0 0 0 1]
10[1 0 0 1 0 0 0 0 0 0 1]
11[1 0 1 0 0 0 0 0 0 0 0 1]
12[1 0 0 1 0 0 0 0 0 0 0 0 1]
13[1 1 0 1 1 0 0 0 0 0 0 0 0 1]
14[1 0 0 0 0 1 0 0 0 0 0 0 0 0 1]
15[1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
16[1 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 1]
17[1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
18[1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
19[1 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
20[1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
21[1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
22[1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
23[1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
24[1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
25[1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
26[1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
27[1 1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
28[1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
29[1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
30[1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
31[1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
32[1 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
*/



/* Number of original signatures */
#define SIGMA 64U
/* Number of equations of derivative public key */
#define ALPHA 2U

#if ((SIGMA*ALPHA) < K)
    #error "The level of security is less than K"
#endif

#if (ALPHA > HFEm)
    #error "The derivative public key cannot have more equations than the \
    true public key"
#endif

/* It is useless to want a high alpha, because it produces big signatures */
#if (ALPHA > NB_BITS_UINT)
    #error "The implementation does not support alpha asking multiprecision"
#endif


/* Degree k of extension of GF(2), for the MAC polynomial */
#define K_MAC 21U
/* Size to store one element of GF(2^k) */
#define UINTk uint32_t

/* Choice of trinom to modular reduction in GF(2^k) */
#define __TRINOMPKI__ 
/*#define __PENTANOMPKI__ */

#ifdef __TRINOMPKI__
    #define K_3 2U
#endif

/* Warning: k1 < k2 < k3 is required */
#ifdef __PENTANOMPKI__
    #define K_3 5U
    #define K_2 3U
    #define K_1 1U
#endif


/* Z a set of Tau points in GF(2^k), Tau is a power of two */
#define Log2_Tau 18
#define Tau (1U<<Log2_Tau)

#if (Log2_Tau > K_MAC)
    #error "Z is a set in GF(2^k), so Z cannot have more elements than GF(2^k)"
#endif

/* O a set of v points, O is in Z */
#define PKI_V 18U
/* The public key is 2^DELTA hash */
/* Choose DELTA=floor(Log_2(PKI_V)) is optimal to minimize |pk|+|sign| */
#define DELTA 4U
#define TWO_POW_DELTA (1U<<DELTA)

#if (v > Tau)
    #error "O is a set in Z, so O cannot have more elements than Z"
#endif

#if (DELTA > Log2_Tau)
    #error "Requirement: DELTA<=Log2_Tau, DELTA is the number of leaves of the \
            Merkle tree"
#endif

/* To generate Z a set of Tau points of GF(2^k) */
#define GENERATE_Z(seed,Z_vec) \
SPONGE((unsigned char*)(seed),K>>3,(unsigned char*)(Z_vec),SIZE_VEC_POINTS<<3);





#define NB_BYTES_GF2K_MAC ((K_MAC>>3) + ((K_MAC&7)?1:0))

/* Number of element of GF(2^k) that it can store in one word */
#define K_QUO (NB_BITS_UINT/K_MAC)
/* Number of unused bits in one word */
#define K_REM (NB_BITS_UINT%K_MAC)
/* Number of used bits in one word */
#define K_USED_BITS (NB_BITS_UINT-K_REM)

/* Mask for arithmetic in GF(2^k) */
#define PKI_MASK mask32(K_MAC)


/* Values of shift to have access at one element of GF(2^k) in one word */
#if (K_QUO==2)
    static const unsigned int K_shift[K_QUO]={0,K_MAC};
#elif (K_QUO==3)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1};
#elif (K_QUO==4)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3};
#elif (K_QUO==5)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2};
#elif (K_QUO==6)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5};
#elif (K_QUO==7)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6};
#elif (K_QUO==8)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7};
#elif (K_QUO==9)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7,K_MAC<<3};
#elif (K_QUO==10)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7,K_MAC<<3,K_MAC*9};
#elif (K_QUO==12)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7,K_MAC<<3,K_MAC*9,K_MAC*10,K_MAC*11};
#elif (K_QUO==16)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3\
,K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7,K_MAC<<3,K_MAC*9,K_MAC*10,K_MAC*11,K_MAC*12,\
K_MAC*13,K_MAC*14,K_MAC*15};
#elif (K_QUO==21)
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7,K_MAC<<3,K_MAC*9,K_MAC*10,K_MAC*11,K_MAC*12,\
K_MAC*13,K_MAC*14,K_MAC*15,K_MAC<<4,K_MAC*17,K_MAC*18,K_MAC*19,K_MAC*20};
#else
    static const unsigned int K_shift[K_QUO]={0,K_MAC,K_MAC<<1,K_MAC*3,\
K_MAC<<2,K_MAC*5,K_MAC*6,K_MAC*7,K_MAC<<3,K_MAC*9,K_MAC*10,K_MAC*11,K_MAC*12,\
K_MAC*13,K_MAC*14,K_MAC*15,K_MAC<<4,K_MAC*17,K_MAC*18,K_MAC*19,K_MAC*20,\
K_MAC*21,K_MAC*22,K_MAC*23,K_MAC*24,K_MAC*25,K_MAC*26,K_MAC*27,K_MAC*28,\
K_MAC*29,K_MAC*30,K_MAC*31};
#endif

/* Access at one element of GF(2^k) in one word */
#define TAKE_COEF(C,i) (((C)>>K_shift[i])&PKI_MASK)
#define PUT_COEF(C,i) (((UINT)(C))<<K_shift[i])




/* Number of coefficients in GF(2^k) of a mac polynom, sup(NB_MONOM_PK/k_MAC) */
#define NB_COEFS_MAC ((NB_MONOM_PK/K_MAC)+((NB_MONOM_PK%K_MAC)?1:0))
#define DEGREE_MAC (NB_COEFS_MAC-1)

/* K_QUO elements of GF(2^k) are stored in one word of a MAC polynomial */
#define MAC_QUO (NB_COEFS_MAC/K_QUO)
/* Number of elements of  GF(2^k) in the last word */
#define MAC_REM (NB_COEFS_MAC%K_QUO)
/* Number of word for a mac, sup(NB_COEFS_MAC/K_QUO) */
#define SIZE_MAC (MAC_QUO+(MAC_REM?1:0))

#define MALLOC_MAC (UINT*)malloc(SIZE_MAC*sizeof(UINT))
#define CALLOC_MAC (UINT*)calloc(SIZE_MAC,sizeof(UINT))

/* Mask to remove the useless bits in a word */
#if K_REM
    #define MASK_QUO mask64(K_USED_BITS)
#endif
/* Mask to remove the useless bits of the last word */
/* (K_shift[MAC_REM] != 0 when used) */
#define MASK_REM mask64(K_shift[MAC_REM])



/* K_QUO points of GF(2^k) are stored in one word of a vector of Tau points */
#define Tau_QUO (Tau/K_QUO)
#define Tau_REM (Tau%K_QUO)
#define SIZE_VEC_POINTS (Tau_QUO + (Tau_REM?1:0))

#define MASK_Tau_REM mask64(K_shift[Tau_REM])


/* K_QUO points of GF(2^k) are stored in one word of a vector of v points */
#define V_QUO (PKI_V/K_QUO)
#define V_REM (PKI_V%K_QUO)
#define SIZE_VEC_POINTS_V (V_QUO + (V_REM?1:0))

#define MASK_V_REM mask64(K_shift[V_REM])


/* K_QUO points of GF(2^k) are stored in one word of a vector of m points */
#define m_QUO (HFEm/K_QUO)
#define m_REM (HFEm%K_QUO)
#define SIZE_VEC_POINTS_m (m_QUO + (m_REM?1:0))

#define MASK_m_REM mask64(K_shift[m_REM])


/****************** MACRO USEFUL FOR SIZE ******************/

/* sigma signatures */
#define SIZE_SIGMA_SIGN (SIGMA*NB_WORD_GFqnv)
/* R, alpha MQ equations */
#define SIZE_R_MQ (NB_WORD_EQUATION*ALPHA)
/* Sum of the both */
#define ACCESS_POINTS (SIZE_SIGMA_SIGN+SIZE_R_MQ)
/* v evaluations of m mac polynomials in GF(2^k) */
#define SIZE_V_EVALUATIONS (PKI_V*SIZE_VEC_POINTS_m)
#define ACCESS_PATH (ACCESS_POINTS+SIZE_V_EVALUATIONS)
/* Length of one Merkle path */
#define LEN_PATH (Log2_Tau-DELTA)
#define SIZE_PATH (LEN_PATH*SIZE_DIGEST_UINT)
#define SIZE_OPEN_PATH_HASH (PKI_V*SIZE_PATH)

/* Sums of the parts of the signature */
#define SIZE_PKI_SIGNATURE (ACCESS_PATH+SIZE_OPEN_PATH_HASH)
#define SIZE_PKI_SIGNATURE_BYTES (SIZE_PKI_SIGNATURE<<3)


#define SIZE_ROOTS_MERKLE (SIZE_DIGEST_UINT*TWO_POW_DELTA)
/* pk is the smallest floor of the Merkle tree, 2^delta hash,
   and a seed of K bits is added to generate Tau */
#if (K_MAC==Log2_Tau)
    #define SIZE_NEW_PK SIZE_ROOTS_MERKLE
#else
    #define SIZE_NEW_PK (SIZE_ROOTS_MERKLE + (K>>6))
#endif
#define SIZE_NEW_PK_BYTES (SIZE_NEW_PK<<3)

/* 2^delta Merkle subtrees (without the roots because they are the public key) 
 */
#define SIZE_SECRET_TREE (SIZE_DIGEST_UINT*((Tau-TWO_POW_DELTA)<<1))
/* Size of the HFE public key, with an other representation 
 * (the equations are stored one by one, and not monom by monom) */
#define SIZE_PK2 NB_WORD_mEQUATIONS
#define ACCESS_SECRET_TREE (SIZE_SK+SIZE_PK2)
/* New sk: HFE secret key + HFE public key + the Merkle's trees */
#if (K_MAC==Log2_Tau)
    #define SIZE_NEW_SK (ACCESS_SECRET_TREE+SIZE_SECRET_TREE)
#else
    /* Add the seed from the public key */
    #define SIZE_NEW_SK (ACCESS_SECRET_TREE+SIZE_SECRET_TREE+(K>>6))
#endif
#define SIZE_NEW_SK_BYTES (SIZE_NEW_SK<<3)


/* Number of node without the Tau leaves */
#define NB_NODE_WITHOUT_LEAVES (Tau-(TWO_POW_DELTA<<1))


/****************** ARITHMETIC FUNCTIONS FOR PKI ******************/

#ifdef __TRINOMPKI__
    #if (K_3==1)
        #define PKIREM(P,Pol,Q) REM32_TRINOM_K3_1(P,Pol,K_MAC,Q,PKI_MASK)
    #else
        #define PKIREM(P,Pol,Q,R) REM32_TRINOM(P,Pol,K_MAC,K_3,Q,R,PKI_MASK)
    #endif
#else
    #define PKIREM(P,Pol,Q,R) REM32_PENTANOM(P,Pol,K_MAC,K_1,K_2,K_3,Q,R,PKI_MASK)
#endif


#if (NB_WORD_GFqm == 1)
    #define PKIDOTPRODUCTM DOTPRODUCT64
#elif (NB_WORD_GFqm == 2)
    #define PKIDOTPRODUCTM DOTPRODUCT128
#elif (NB_WORD_GFqm == 3)
    #define PKIDOTPRODUCTM DOTPRODUCT192
#elif (NB_WORD_GFqm == 4)
    #define PKIDOTPRODUCTM DOTPRODUCT256
#elif (NB_WORD_GFqm == 5)
    #define PKIDOTPRODUCTM DOTPRODUCT320
#elif (NB_WORD_GFqm == 6)
    #define PKIDOTPRODUCTM DOTPRODUCT384
#endif


#endif
