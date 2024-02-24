#include "padMac.h"


/* If K_REM==0, mq == pad_mq and this function becomes useless */
#if K_REM
/*  Input: one equation quadratic of GF(2)[x1,...,x_(n+v)]

    Output: a MAC polynomial, store K_QUO elements of GF(2^k) in one word,
            and the word is padding with zeros

    This function takes the bit of mq k by k bits, to generate elements of
    GF(2^k).
*/
void padMac(UINT* pad_mq, const UINT* mq)
{
    unsigned int j,nb_bits=0,bits_quo,bits_rem;

    #if MAC_REM
    for(j=0;j<MAC_QUO;++j)
    #else
    for(j=0;j<(MAC_QUO-1);++j)
    #endif
    {
        bits_quo=nb_bits>>6;
        bits_rem=nb_bits&63;
        pad_mq[j]=(mq[bits_quo]>>bits_rem);
        /* The bits are on two words of mq */
        if(bits_rem>K_REM)
        {
            pad_mq[j]^=mq[bits_quo+1]<<(64-bits_rem);
        }
        /* Clean the word */
        pad_mq[j]&=MASK_QUO;
        nb_bits+=K_USED_BITS;
    }

    /* The last word */
    bits_quo=nb_bits>>6;
    bits_rem=nb_bits&63;
    pad_mq[j]=(mq[bits_quo]>>bits_rem);
    /* The bits are on two words of mq */
    if((bits_quo+1)<NB_WORD_EQUATION)
    {
        pad_mq[j]^=mq[bits_quo+1]<<(64-bits_rem);
    }
    /* Clean the word */
    #if MAC_REM
        pad_mq[j]&=MASK_REM;
    #else
        pad_mq[j]&=MASK_QUO;
    #endif
}
#endif
