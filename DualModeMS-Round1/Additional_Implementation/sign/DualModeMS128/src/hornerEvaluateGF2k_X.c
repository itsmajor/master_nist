#include "hornerEvaluateGF2k_X.h"


#ifdef ENABLED_AVX_MUL
#include "init.h"
#include "extract.h"


#ifdef __TRINOMPKI__

/* Optimization of the modular reduction for K_3==1 */
#if (K_3==1)
    #define LOOPJavx(NB_IT) \
        for(j=NB_IT;j!=(unsigned int)(-1);--j)\
        {\
            /* Multiply by X */\
            r_mul=_mm_clmulepi64_si128(x,r,0);\
            /* Modular reduction by a trinom */\
            shift1=_mm_srli_epi64(r_mul,K_MAC);\
            r=_mm_xor_si128(r_mul,shift1);\
            shift2=_mm_slli_epi64(shift1,K_3);\
            r_mul=_mm_xor_si128(r,shift2);\
            /* Add next coefficient of P */\
            INIT64(r,(*P_cp)>>K_shift[j]);\
            shift1=_mm_xor_si128(r,r_mul);\
            r=_mm_and_si128(shift1,mask_128);\
        }

    #define LOOPJavx2(NB_IT,r_load) \
        for(j=NB_IT;j!=(unsigned int)(-1);--j)\
        {\
            /* Multiply by X */\
            r_mul=_mm_clmulepi64_si128(x,r,0);\
            /* Modular reduction by a trinom */\
            shift1=_mm_srli_epi64(r_mul,K_MAC);\
            r=_mm_xor_si128(r_mul,shift1);\
            shift2=_mm_slli_epi64(shift1,K_3);\
            r_mul=_mm_xor_si128(r,shift2);\
            /* Add next coefficient of P */\
            r=_mm_srli_epi64(r_load,K_shift[j]);\
            shift1=_mm_xor_si128(r,r_mul);\
            r=_mm_and_si128(shift1,mask_128);\
        }
#else
    #define LOOPJavx(NB_IT) \
        for(j=NB_IT;j!=(unsigned int)(-1);--j)\
        {\
            /* Multiply by X */\
            r_mul=_mm_clmulepi64_si128(x,r,0);\
            /* Modular reduction by a trinom */\
            shift1=_mm_srli_epi64(r_mul,K_MAC);\
            r=_mm_xor_si128(r_mul,shift1);\
            shift2=_mm_slli_epi64(shift1,K_3);\
            r_mul=_mm_xor_si128(r,shift2);\
            shift1=_mm_srli_epi64(shift2,K_MAC);\
            r=_mm_xor_si128(r_mul,shift1);\
            shift2=_mm_slli_epi64(shift1,K_3);\
            r_mul=_mm_xor_si128(r,shift2);\
            /* Add next coefficient of P */\
            INIT64(r,(*P_cp)>>K_shift[j]);\
            shift1=_mm_xor_si128(r,r_mul);\
            r=_mm_and_si128(shift1,mask_128);\
        }

    #define LOOPJavx2(NB_IT,r_load) \
        for(j=NB_IT;j!=(unsigned int)(-1);--j)\
        {\
            /* Multiply by X */\
            r_mul=_mm_clmulepi64_si128(x,r,0);\
            /* Modular reduction by a trinom */\
            shift1=_mm_srli_epi64(r_mul,K_MAC);\
            r=_mm_xor_si128(r_mul,shift1);\
            shift2=_mm_slli_epi64(shift1,K_3);\
            r_mul=_mm_xor_si128(r,shift2);\
            shift1=_mm_srli_epi64(shift2,K_MAC);\
            r=_mm_xor_si128(r_mul,shift1);\
            shift2=_mm_slli_epi64(shift1,K_3);\
            r_mul=_mm_xor_si128(r,shift2);\
            /* Add next coefficient of P */\
            r=_mm_srli_epi64(r_load,K_shift[j]);\
            shift1=_mm_xor_si128(r,r_mul);\
            r=_mm_and_si128(shift1,mask_128);\
        }
#endif

/*  Input:
        P a polynomial in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        res an element in GF(2^k), res=P(X)

    The method of Horner is used to evaluate.
*/
UINTk hornerEvaluateGF2k_X(const UINT* P, UINTk X)
{
    __m128i r_load,r_load2,r,x,r_mul,shift1,shift2,mask_128;
    const UINT* P_cp;
    unsigned int i,j;

    INIT64(x,X);
    INIT64(mask_128,PKI_MASK);

    #if MAC_REM
        P_cp=P+SIZE_MAC-1;
        INIT64(r,TAKE_COEF(*P_cp,MAC_REM-1));
        LOOPJavx(MAC_REM-2);
    #else
        P_cp=P+SIZE_MAC;
        INIT128_ZERO(r);
    #endif

    for(i=0;i<(MAC_QUO>>1);++i)
    {
        P_cp-=2;
        INIT128(r_load,P_cp);
        r_load2=RIGHT_MOVE64(r_load);
        LOOPJavx2(K_QUO-1,r_load2);
        LOOPJavx2(K_QUO-1,r_load);
    }

    #if(MAC_QUO&1)
        --P_cp;
        INIT64(r_load,*P_cp);
        LOOPJavx2(K_QUO-1,r_load);
    #endif

    return (UINTk)EXTRACT64(r,0);
}


/*  Input:
        P a vector of m polynom in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        vec_p a vector of m elements in GF(2^k),
        vec_p = P_1(X),P_2(X),...,P_m(X)

    The method of Horner is used to evaluate.
*/
void hornerEvaluateGF2k_X_multipoly(UINT* vec_p, const UINT* P, UINTk X)
{
    __m128i r_load,r_load2,r,x,r_mul,shift1,shift2,mask_128;
    const UINT* P_cp=P+HFEm*SIZE_MAC;
    unsigned int i,j,k;

    INIT64(x,X);
    INIT64(mask_128,PKI_MASK);

    for(k=0;k<SIZE_VEC_POINTS_m;++k)
    {
        vec_p[k]=0;
    }

    for(k=HFEm-1;k!=(unsigned int)(-1);--k)
    {
        #if MAC_REM
            --P_cp;
            INIT64(r,TAKE_COEF(*P_cp,MAC_REM-1));
            LOOPJavx(MAC_REM-2);
        #else
            INIT128_ZERO(r);
        #endif

        for(i=0;i<(MAC_QUO>>1);++i)
        {
            P_cp-=2;
            INIT128(r_load,P_cp);
            r_load2=RIGHT_MOVE64(r_load);
            LOOPJavx2(K_QUO-1,r_load2);
            LOOPJavx2(K_QUO-1,r_load);
        }

        #if(MAC_QUO&1)
            --P_cp;
            INIT64(r_load,*P_cp);
            LOOPJavx2(K_QUO-1,r_load);
        #endif

        vec_p[k/K_QUO]^=PUT_COEF(EXTRACT64(r,0),k%K_QUO);
    }
}

/* __PENTANOMPKI__ */
#else

#include "mul.h"
#include "rem.h"

#define LOOPJ(NB_IT) \
    for(j=NB_IT;j!=(unsigned int)(-1);--j)\
    {\
        /* Multiply by X */\
        INIT64(r,res);\
        res_mul=MUL32(x,r);\
        /* Modular reduction */\
        PKIREM(res,res_mul,Q,R);\
        /* Add next coefficient of P */\
        res^=TAKE_COEF(*P_cp,j);\
    }


/*  Input:
        P a polynomial in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        res an element in GF(2^k), res=P(X)

    The method of Horner is used to evaluate.
*/
UINTk hornerEvaluateGF2k_X(const UINT* P, UINTk X)
{
    __m128i r,x;
    const UINT* P_cp;
    uint64_t res_mul,Q,R;
    unsigned int i,j;
    UINTk res;

    INIT64(x,X);

    #if MAC_REM
        P_cp=P+SIZE_MAC-1;
        res=TAKE_COEF(*P_cp,MAC_REM-1);
        LOOPJ(MAC_REM-2);
    #else
        P_cp=P+SIZE_MAC;
        res=0;
    #endif

    for(i=0;i<MAC_QUO;++i)
    {
        --P_cp;
        LOOPJ(K_QUO-1);
    }

    return res;
}


/*  Input:
        P a vector of m polynom in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        vec_p a vector of m elements in GF(2^k),
        vec_p = P_1(X),P_2(X),...,P_m(X)

    The method of Horner is used to evaluate.
*/
void hornerEvaluateGF2k_X_multipoly(UINT* vec_p, const UINT* P, UINTk X)
{
    __m128i r,x;
    const UINT* P_cp=P+HFEm*SIZE_MAC;
    uint64_t res_mul,Q,R;
    unsigned int i,j,k;
    UINTk res;

    INIT64(x,X);

    for(k=0;k<SIZE_VEC_POINTS_m;++k)
    {
        vec_p[k]=0;
    }

    for(k=HFEm-1;k!=(unsigned int)(-1);--k)
    {
        #if MAC_REM
            --P_cp;
            res=TAKE_COEF(*P_cp,MAC_REM-1);
            LOOPJ(MAC_REM-2);
        #else
            res=0;
        #endif

        for(i=0;i<MAC_QUO;++i)
        {
            --P_cp;
            LOOPJ(K_QUO-1);
        }

        vec_p[k/K_QUO]^=PUT_COEF(res,k%K_QUO);
    }
}

#endif


/* !ENABLED_AVX_MUL */
#else

#include <gf2x/gf2x_mul1.h>
#include "rem.h"

/* If the irreductible polynomial is a pentanom,
 * it is impossible that K_3==1 */
#if (K_3==1)
    /* It is necessarily a trinom */
    #define FUNCTION_REM PKIREM(res,*res_mul,Q);
#else
    #define FUNCTION_REM PKIREM(res,*res_mul,Q,R);
#endif


#define LOOPJ(NB_IT) \
    for(j=NB_IT;j!=(unsigned int)(-1);--j)\
    {\
        /* Multiply by X */\
        gf2x_mul1(res_mul,X,res);\
        /* Modular reduction by a trinom */\
        FUNCTION_REM;\
        /* Add next coefficient of P */\
        res^=TAKE_COEF(*P_cp,j);\
    }


/*  Input:
        P a polynomial in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        res an element in GF(2^k), res=P(X)

    The method of Horner is used to evaluate.
*/
UINTk hornerEvaluateGF2k_X(const UINT* P, UINTk X)
{
    const UINT* P_cp;
    uint64_t res_mul[2],Q;
    #if (K_3!=1)
        uint64_t R;
    #endif
    unsigned int i,j;
    UINTk res;

    #if MAC_REM
        P_cp=P+SIZE_MAC-1;
        res=TAKE_COEF(*P_cp,MAC_REM-1);
        LOOPJ(MAC_REM-2);
    #else
        P_cp=P+SIZE_MAC;
        res=0;
    #endif

    for(i=0;i<MAC_QUO;++i)
    {
        --P_cp;
        LOOPJ(K_QUO-1);
    }

    return res;
}


/*  Input:
        P a vector of m polynom in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        vec_p a vector of m elements in GF(2^k),
        vec_p = P_1(X),P_2(X),...,P_m(X)

    The method of Horner is used to evaluate.
*/
void hornerEvaluateGF2k_X_multipoly(UINT* vec_p, const UINT* P, UINTk X)
{
    const UINT* P_cp=P+HFEm*SIZE_MAC;
    uint64_t res_mul[2],Q;
    #if (K_3!=1)
        uint64_t R;
    #endif
    unsigned int k,i,j;
    UINTk res;

    for(k=0;k<SIZE_VEC_POINTS_m;++k)
    {
        vec_p[k]=0;
    }

    for(k=HFEm-1;k!=(unsigned int)(-1);--k)
    {
        #if MAC_REM
            --P_cp;
            res=TAKE_COEF(*P_cp,MAC_REM-1);
            LOOPJ(MAC_REM-2);
        #else
            res=0;
        #endif

        for(i=0;i<MAC_QUO;++i)
        {
            --P_cp;
            LOOPJ(K_QUO-1);
        }

        vec_p[k/K_QUO]^=PUT_COEF(res,k%K_QUO);
    }
}


#endif


