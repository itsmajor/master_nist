#include "hornerEvaluateGF2k_X.h"

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


