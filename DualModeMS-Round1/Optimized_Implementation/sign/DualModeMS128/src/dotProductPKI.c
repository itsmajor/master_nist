#include "dotProductPKI.h"


/*  Input: t a row vector of m elements in GF(2)
           vec_p a column vector of m elements of GF(2^k)

    Output: t*vec_p the dot product, an element of GF(2^k)
*/
/* It is to compute t*P(ri), one call for compute one row of t of size 
 * (alpha*m) by P(ri) */
UINTk dotProductPKI(const UINT* t, const UINT* vec_p)
{
    UINT bit_ir,mask;
    unsigned int iq,ir,i=0;
    UINTk res=0;

    for(iq=0;iq<HFEmq;++iq)
    {
        bit_ir=t[iq];
        for(ir=0;ir<NB_BITS_UINT;++ir,++i)
        {
            mask=-(bit_ir&1UL);
            res^=mask&TAKE_COEF(vec_p[i/K_QUO],i%K_QUO);
            bit_ir>>=1;
        }
    }
    #if HFEmr
        bit_ir=t[iq];
        for(ir=0;ir<HFEmr;++ir,++i)
        {
            mask=-(bit_ir&1UL);
            res^=mask&TAKE_COEF(vec_p[i/K_QUO],i%K_QUO);
            bit_ir>>=1;
        }
    #endif

    return res;
}

