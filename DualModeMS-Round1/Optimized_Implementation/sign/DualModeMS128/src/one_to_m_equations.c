#include "one_to_m_equations.h"


#define LOOPJR(NB_IT) \
    for(jr=1;jr<NB_IT;++jr)\
    {\
        *pk2_cp^=(((*pk_cp)>>ir)&1UL)<<jr;\
        pk_cp+=NB_WORD_GFqm;\
    }\
    ++pk2_cp;

#if HFENr
    #define LOOPJQ \
        /* To have equivalence between *pk_cp and pk_cp[iq] */\
        pk_cp=pk+iq;\
        for(jq=0;jq<HFENq;++jq)\
        {\
            /* jr=0 */ \
            *pk2_cp=((*pk_cp)>>ir)&1UL;\
            pk_cp+=NB_WORD_GFqm;\
            LOOPJR(NB_BITS_UINT);\
        }\
\
        /* jr=0 */ \
        *pk2_cp=((*pk_cp)>>ir)&1UL;\
        pk_cp+=NB_WORD_GFqm;\
        LOOPJR(HFENr);
#else
    #define LOOPJQ \
        /* To have equivalence between *pk_cp and pk_cp[iq] */\
        pk_cp=pk+iq;\
        for(jq=0;jq<HFENq;++jq)\
        {\
            /* jr=0 */ \
            *pk2_cp=((*pk_cp)>>ir)&1UL;\
            pk_cp+=NB_WORD_GFqm;\
            LOOPJR(NB_BITS_UINT);\
        }
#endif



/* Change the representation of public key */
/* One equation in GF(2^m)[x1,...x_(n+v)] becomes m equations in 
 * GF(2)[x1,...x_(n+v)] */
void one_to_m_equations(UINT* pk2, const UINT* pk)
{
    const UINT* pk_cp;
    UINT* pk2_cp=pk2;
    unsigned int iq,ir,jq,jr;

    /* For each equation of result */
    for(iq=0;iq<HFEmq;++iq)
    {
        for(ir=0;ir<NB_BITS_UINT;++ir)
        {
            /* Loop on every monoms */
            LOOPJQ;
        }
    }

    #if HFEmr
        for(ir=0;ir<HFEmr;++ir)
        {
            /* Loop on every monoms */
            LOOPJQ;
        }
    #endif
}

