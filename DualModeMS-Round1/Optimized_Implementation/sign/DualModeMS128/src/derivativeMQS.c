#include "derivativeMQS.h"



/*  Input: P a column vector of m quadratic equations in GF(2)[x1,...,x_(n+v)]
           t a matrix alpha*m in GF(2)

    Output: R, a column vector of alpha quadratic equations 
            in GF(2)[x1,...,x_(n+v)], R = t*P

    Requirement: ALPHA<=NB_BITS_UINT
*/
/* It is not in constant time, because R is not a sensitive data */
void derivativeMQS(alpha_mqnv_gf2 R, cst_M_alpha_m_gf2 t, cst_m_mqnv_gf2 P)
{
    #if (ALPHA!=1)
    alpha_mqnv_gf2 R_cp=R;
    #endif
    cst_m_mqnv_gf2 P_cp=P;
    cst_M_alpha_m_gf2 t_cp;
    UINT bit_jr;
    unsigned int i,jq,jr,k;

    /* Initialize to 0 */
    for(i=0;i<SIZE_R_MQ;++i)
    {
        R[i]=0UL;
    }

    t_cp=t;
    /* For each row of t, dot product with P */
    #if (ALPHA!=1)
    for(i=0;i<ALPHA;++i)
    {
        P_cp=P;
    #endif
        /* For each complete block of NB_BITS_UINT column of t */
        for(jq=0;jq<HFEmq;++jq)
        {
            bit_jr=*t_cp;
            /* For each column of a block */
            for(jr=0;jr<NB_BITS_UINT;++jr)
            {
                /* if the bit of t is 1, the equation of P is added */
                if(bit_jr&1UL)
                {
                    /* Add the equation of P */
                    for(k=0;k<NB_WORD_EQUATION;++k)
                    {
                        #if (ALPHA!=1)
                        R_cp[k]^=P_cp[k];
                        #else
                        R[k]^=P_cp[k];
                        #endif
                    }
                }
                P_cp+=NB_WORD_EQUATION;
                bit_jr>>=1;                
            }
            ++t_cp;
        }
        /* The last block of t */
        #if HFEmr
            bit_jr=*t_cp;
            /* For each column of a block */
            for(jr=0;jr<HFEmr;++jr)
            {
                /* if the bit of t is 1, the equation of P is added */
                if(bit_jr&1UL)
                {
                    /* Add the equation of P */
                    for(k=0;k<NB_WORD_EQUATION;++k)
                    {
                        #if (ALPHA!=1)
                        R_cp[k]^=P_cp[k];
                        #else
                        R[k]^=P_cp[k];
                        #endif
                    }
                }
                P_cp+=NB_WORD_EQUATION;
                bit_jr>>=1;                
            }
            ++t_cp;
        #endif

    #if (ALPHA!=1)
        R_cp+=NB_WORD_EQUATION;
    }
    #endif
}
