#include "evalMQ.h"
#include "bit.h"



#define LOOPIR(NB_IT) \
        bit_ir=si[iq]; \
        for(ir=0;ir<NB_IT;++ir) \
        { \
            if(bit_ir&1UL) \
            { \
                bits_quo=nb_bits>>6; \
                bits_rem=nb_bits&63; \
                if(ir==bits_rem) \
                { \
                    /* Clean the first word */ \
                    res^=((mq[bits_quo]>>ir)<<ir)&si[iq]; \
                    for(j=1;j<(NB_WORD_GFqnv-iq);++j) \
                    { \
                        res^=mq[bits_quo+j]&si[iq+j]; \
                    } \
                } else \
                { \
                    if(ir<bits_rem) \
                    { \
                        sum=64-bits_rem+ir; \
                        /* Clean the first word */ \
                        res^=(((mq[bits_quo]>>bits_rem)<<ir)^(mq[bits_quo+1]<<sum))&si[iq]; \
                        for(j=1;j<(NB_WORD_GFqnv-iq);++j) \
                        { \
                            res^=((mq[bits_quo+j]>>(64-sum))^(mq[bits_quo+j+1]<<sum))&si[iq+j]; \
                        } \
                    } else \
                    { \
                        sum=ir-bits_rem; \
                        /* Clean the first word */ \
                        res^=((mq[bits_quo]>>bits_rem)<<ir)&si[iq]; \
                        for(j=1;j<(NB_WORD_GFqnv-iq);++j) \
                        { \
                            res^=((mq[bits_quo+j-1]>>(64-sum))^(mq[bits_quo+j]<<sum))&si[iq+j]; \
                        } \
                    } \
                } \
            } \
            nb_bits+=HFEnv-(iq*NB_BITS_UINT+ir); \
            bit_ir>>=1; \
        }


/*  Input: mq, alpha equations in GF(2)[x1,...,x_(n+v)]
           si, a vector of n+v elements of GF(2)

    Output: the evaluation of mq in si, a vector of alpha elements of GF(2)
*/
UINT evalMQ(cst_alpha_mqnv_gf2 mq, cst_vecnv_gf2 si)
{
    UINT res=(*mq)&1UL,bit_ir;
    unsigned int iq,ir,j,nb_bits=1,bits_quo,bits_rem,sum;

    /* For each monom */
    for(iq=0;iq<HFEnvq;++iq)
    {
        LOOPIR(NB_BITS_UINT);
    }
    #if HFEnvr
        LOOPIR(HFEnvr);
    #endif

    XORBITS64(res);
    return res;
}

