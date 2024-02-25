#include "sign_openPKI.hpp"
#include <stdlib.h>
BEGIN_EXTERNC
    #include <libXKCP.a.headers/SimpleFIPS202.h>
    #include <libXKCP.a.headers/SP800-185.h>
    #include <libXKCP.a.headers/KeccakSponge.h>
END_EXTERNC
#include "bit.h"
#include "init.h"

#if K_REM
    #include "padMac.h"
#endif
#include "hornerEvaluateGF2k_X.hpp"
#include "dotProductPKI.h"
#include "merkleTree.h"
#include "evalMQ.h"



/* Input:
    m a document
    len the size of document (in byte)
    sm the signature
    pk the public key: the roots of the Merkle tree

   Output:
    0 for a valid signature
    1 if R(s_i) != t*H(m||i), R_mac(r_i) != t*P_mac(r_i) \
    or if Merkle.verify return false
    ERROR_ALLOC for an error from malloc/calloc functions
*/
int sign_openPKI(const unsigned char* m, size_t len, const UINT* sm, 
                 const UINT* pk)
{
    Vec<GF2EX> R_mac_NTL;

    UINT H1[SIZE_DIGEST_UINT];
    static_M_alpha_m_gf2 t[ALPHA*NB_WORD_GFqm];
    #if (ALPHA!=1)
        UINT tmp;
    #endif
    vecalpha_gf2 tH,R_eval;
    int ret;
    unsigned int i,k;
    #if (ALPHA!=1)
        unsigned int j;
    #endif
    UINTk tmp_k;

    TupleElement tuples[2];
    tuples[0].input=(BitSequence*)m;
    tuples[0].inputBitLen=(BitLength)(len<<3);

    /* Compute H(m||s_1||...||s_sigma) */
    tuples[1].input=(BitSequence*)sm;
    tuples[1].inputBitLen=(BitLength)(SIZE_SIGMA_SIGN<<6);
    ret=TUPLEHASH(tuples,2,(BitSequence*)t,(ALPHA*NB_WORD_GFqm)<<6,NULL,0);
    if(ret)
    {
        return ret;
    }
    #if HFEmr
        /* Clean the last word of each row */
        for(i=1;i<=ALPHA;++i)
        {
            t[i*NB_WORD_GFqm-1]&=HFE_MASKm;
        }
    #endif

    /* SIGMA verifications */
    tuples[1].input=(BitSequence*)(&i);
    tuples[1].inputBitLen=32;
    for(i=0;i<SIGMA;++i)
    {
        /* Compute H(m||i) */
        ret=TUPLEHASH(tuples,2,(BitSequence*)H1,SIZE_DIGEST<<3,NULL,0);
        if(ret)
        {
            return ret;
        }
        /* Compute t*H(m||i) */

        /* Because the last word of each row of t in cleaned,
         * it does not need to clean H1 */
        PKIDOTPRODUCTM(tH,t,H1);

        /* Requirement: ALPHA<=NB_BITS_UINT */
        #if (ALPHA!=1)
            for(j=1;j<ALPHA;++j)
            {
                /* dot product j-th row of t by the m first bits of H1 */
                PKIDOTPRODUCTM(tmp,t+j*NB_WORD_GFqm,H1);
                /* xor the computed bit */
                tH^=tmp<<j;
            }
        #endif

        /* Compute R(s_i) */
        R_eval=evalMQ(sm+SIZE_SIGMA_SIGN,sm+i*NB_WORD_GFqnv);

        /* Requirement: ALPHA<=NB_BITS_UINT */
        #if (ALPHA!=1)
            for(j=1;j<ALPHA;++j)
            {
                R_eval^=evalMQ(sm+SIZE_SIGMA_SIGN+j*NB_WORD_EQUATION,\
                                sm+i*NB_WORD_GFqnv)<<j;
            }
        #endif

        /* R(s_i) ?= t*H(m||i) */
        if(R_eval!=tH)
        {
            return 1;
        }
    }


    tuples[1].input=(BitSequence*)sm;
    tuples[1].inputBitLen=(BitLength)(ACCESS_POINTS<<6);

    #if (K_MAC!=Log2_Tau)
        /* Generation of Z, set of Tau points in GF(2^k) */
        UINT* Z_vec=(UINT*)malloc(SIZE_VEC_POINTS*sizeof(UINT));
        VERIFY_ALLOC_RET(Z_vec);

        /* Use the seed to generate Z */
        GENERATE_Z(pk+SIZE_ROOTS_MERKLE,Z_vec);

        /* List of v index of Z, O={Z_vec[index] for v index} */
        uint32_t o[PKI_V];
        /* Compute H(m||s_1||...||s_sigma||R) to generate v index */
        ret=TUPLEHASH(tuples,2,(BitSequence*)(o),PKI_V<<5,NULL,0);

        for(i=0;i<PKI_V;++i)
        {
            /* Mod Tau to have index in {0,...,Tau-1} */
            o[i]&=Tau-1;
        }
    #else
        vecv_gf2k O=(UINT*)malloc(SIZE_VEC_POINTS_V*sizeof(UINT));
        VERIFY_ALLOC_RET(O);

        /* Compute H(m||s_1||...||s_sigma||R) to generate v points */
        ret=TUPLEHASH(tuples,2,(BitSequence*)(O),SIZE_VEC_POINTS_V<<6,NULL,0);
    #endif
    if(ret)
    {
        #if (K_MAC!=Log2_Tau)
            free(Z_vec);
        #else
            free(O);
        #endif
        return ret;
    }

    R_mac_NTL.SetLength(ALPHA);
    #if K_REM
        UINT* mac_pad=(UINT*)malloc(SIZE_MAC*ALPHA*sizeof(UINT));
        if(!mac_pad)
        {
            #if (K_MAC!=Log2_Tau)
                free(Z_vec);
            #else
                free(O);
            #endif
            return ERROR_ALLOC;
        }

        for(i=0;i<ALPHA;++i)
        {
            padMac(mac_pad+i*SIZE_MAC,sm+SIZE_SIGMA_SIGN+i*NB_WORD_EQUATION);
        }

        castMACToVecalphaNTL(R_mac_NTL,mac_pad);
        free(mac_pad);
    #else
        castMACToVecalphaNTL(R_mac_NTL,sm+SIZE_SIGMA_SIGN);
    #endif


    /* For v points */
    for(k=0;k<PKI_V;++k)
    {
        #if (K_MAC!=Log2_Tau)
            /* Take the index of rk in Z */
            tmp_k=o[k];
        #else
            /* Index of rk == rk */
            tmp_k=TAKE_COEF(O[k/K_QUO],k%K_QUO);
        #endif

        /* Verify the opened path of Merkle */
        HASH((unsigned char*)H1,(const unsigned char*)(sm+ACCESS_POINTS+ \
             k*SIZE_VEC_POINTS_m),SIZE_VEC_POINTS_m<<3);

        if(merkleTreeVerify(pk,H1,sm+ACCESS_PATH+k*SIZE_PATH,tmp_k))
        {
            #if (K_MAC!=Log2_Tau)
                free(Z_vec);
            #else
                free(O);
            #endif
            return 1;
        }

        /* Verify R_mac(ri) == t*P_mac(ri) */ 
        /* Requirement: ALPHA<=NB_BITS_UINT */
        #if (K_MAC!=Log2_Tau)
            /* Take the index of rk in Z */
            tmp_k=TAKE_COEF(Z_vec[tmp_k/K_QUO],tmp_k%K_QUO);
        #endif
        for(j=0;j<ALPHA;++j)
        {
            /* t*P_mac(ri) */
            tH=dotProductPKI(t+j*NB_WORD_GFqm,sm+ACCESS_POINTS+\
                             k*SIZE_VEC_POINTS_m);

            R_eval=hornerEvaluateGF2k_X(R_mac_NTL[j],tmp_k);

            if(R_eval!=tH)
            {
                #if (K_MAC!=Log2_Tau)
                    free(Z_vec);
                #else
                    free(O);
                #endif
                return 1;
            }
        }
    }

    #if (K_MAC!=Log2_Tau)
        free(Z_vec);
    #else
        free(O);
    #endif
    R_mac_NTL.kill();
    return 0;
}
