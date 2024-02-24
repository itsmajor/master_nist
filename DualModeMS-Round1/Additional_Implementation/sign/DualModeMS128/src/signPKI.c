#include "signPKI.h"
BEGIN_EXTERNC
    #include <libkeccak.a.headers/SP800-185.h>
    #include <libkeccak.a.headers/KeccakSpongeWidth1600.h>
END_EXTERNC

#include <stdlib.h>
#include "add.h"
#include "init.h"
#include "randombytes.h"
#include "matVecProduct.h"
#include "vecMatProduct.h"
#include "evaluateMQS.h"

#include "chooseRootHFE.hpp"
#if(HFEDeg!=1)
    #include "init_list_differences.h"
#endif

#if K_REM
    #include "padMac.h"
#endif
#include "hornerEvaluateGF2k_X.h"
#include "merkleTree.h"
#include "derivativeMQS.h"



/* Input:
    m a document to sign
    len the size of document (in byte)
    sk the secret key: sk_HFE + pk_HFE + secret Merkle tree

  Output:
    0 if the result is correct, ERROR_ALLOC for error from calloc functions
    sm the signature
*/
/* Format of signature:
    sigma original signatures
    R a derivative system from P, with alpha equations
    PKI_V vector: evaluation of P in PKI_V points
    PKI_V path of Merkle
    a seed of K bits to generate Z (if useful)
*/
int signPKI(UINT* sm, const unsigned char* m, size_t len, const UINT* sk)
{
    static_vecnv_gf2 DR[NB_WORD_GFqnv];
    static_gf2n U[NB_WORD_GFqn];
    UINT H1[SIZE_DIGEST_UINT];
    #if(HFEn>HFEm)
        unsigned char* DR_cp=(unsigned char*)DR;
    #endif
    int ret;
    unsigned int i,k=0;
    UINTk tmp_k;
    #if((HFEm&7)&&(HFEn>HFEm))
        unsigned char rem_char;
    #endif
    static_M_alpha_m_gf2 t[ALPHA*NB_WORD_GFqm];

    TupleElement tuples[2];
    tuples[0].input=(BitSequence*)m;
    tuples[0].inputBitLen=(BitLength)(len<<3);
    tuples[1].input=(BitSequence*)(&i);
    tuples[1].inputBitLen=32;

    int nb_root;
    complete_sparse_monic_gf2nx F_struct;
    #if(HFEDeg!=1)
        init_list_differences(F_struct.L);
    #endif

    #if(HFEv)
        unsigned int i_HFE,j;
        static_vecv_gf2 V[NB_WORD_GFqv];
        UINT* F=MALLOC_HFEPOLY_EVAL;
        VERIFY_ALLOC_RET(F);

        #if (HFEDeg>1)
        static_gf2n tmp_n[NB_WORD_GFqn];
        const UINT* linear_coefs[HFEDegI+1];
        UINT *F_cp;
        const UINT *sk_cp;

        /* X^(2^0) */
        linear_coefs[0]=sk+MQv_GFqn_SIZE;
        /* X^(2^1) */
        sk_cp=linear_coefs[0]+MLv_GFqn_SIZE;
        F_cp=F+2*NB_WORD_GFqn;
        for(i=0;i<HFEDegI;++i)
        {
            /* Copy i quadratic terms */
            for(j=0;j<i;++j)
            {
                /* X^(2^i + 2^j) */
                HFECOPY(F_cp,sk_cp);
                sk_cp+=NB_WORD_GFqn;
                F_cp+=NB_WORD_GFqn;
            }
            /* Store the address of X^(2^(i+1)) */
            linear_coefs[i+1]=sk_cp;
            /* Linear term is not copied */
            sk_cp+=MLv_GFqn_SIZE;
            F_cp+=NB_WORD_GFqn;
        }
        #if HFEDegJ
            /* X^(2^HFEDegI + 2^j) */
            for(j=0;j<HFEDegJ;++j)
            {
                HFECOPY(F_cp,sk_cp);
                sk_cp+=NB_WORD_GFqn;
                F_cp+=NB_WORD_GFqn;
            }
        #endif
        #endif
        F_struct.poly=F;
    #else
        F_struct.poly=sk;
    #endif


    /* SIGMA original signatures */
    for(i=0;i<SIGMA;++i)
    {
        /* Compute H(m||i) */
        ret=TUPLEHASH(tuples,2,(BitSequence*)H1,SIZE_DIGEST<<3,NULL,0);
        if(ret)
        {
            #if HFEv
                free(F);
            #endif
            return ret;
        }

        /* Extract D1 from H1 */
        HFECOPY_M(DR,H1);

        #if(HFEm&7)
            /* Clean the last char to compute rem_char (the last word is cleaned) */
            DR[NB_WORD_GFqm-1]&=HFE_MASKm;
            /* Save the last byte because we need to erase this value by 
             * randombytes */
            #if(HFEn>HFEm)
                rem_char=DR_cp[NB_BYTES_GFqm-1];
            #endif
        #endif

        #if(HFEn>HFEm)
        /* Clean the last word only if it is useful: 
         * if (HFEn&7), it is already cleaned in the do while loop
         * if (!HFEnr), every bits of the word are used
         * if (HFEm&7)&&(NB_WORD_GFqn==NB_WORD_GFqm), the last word is already 
         * cleaned by the previous code */
        #if ((!(HFEn&7)) && HFEnr && ((!(HFEm&7))||(NB_WORD_GFqn!=NB_WORD_GFqm)))
            DR[NB_WORD_GFqn-1]=0UL;
        #endif
        #endif

        do
        {
            #if(HFEn>HFEm)
            /* Compute D1||R1: add random to have n bits, without erased the 
             * m bits */
            #if(HFEm&7)
                /* Generation of R1 */
                randombytes(DR_cp+NB_BYTES_GFqm-1,
                           (unsigned long long)(NB_BYTES_GFqn-NB_BYTES_GFqm+1));
                /* Put HFEm&7 first bits to 0 */
                DR_cp[NB_BYTES_GFqm-1]&=~((1U<<(HFEm&7))-1);
                /* Store rem_char */
                DR_cp[NB_BYTES_GFqm-1]^=rem_char;
            #else
                /* Generation of R1 */
                randombytes(DR_cp+NB_BYTES_GFqm,
                            (unsigned long long)(NB_BYTES_GFqn-NB_BYTES_GFqm));
            #endif

            /* To clean the last char (because of randombytes), the last word is 
             * cleaned */
            #if (HFEn&7)
                DR[NB_WORD_GFqn-1]&=HFE_MASKn;
            #endif
            #endif

            /* Compute S1||X1 = Inv_p(D1,R1) */

            /* Firstly: compute T^(-1) * c */
            matVecProduct(U,sk+NB_UINT_HFEPOLY+MATRIXnv_SIZE,DR);

            /* Secondly: find v with F_HFE(v) = U */

            /* Generation of vinegar variables: v bits */
           #if(HFEv)
                randombytes((unsigned char*)V,(unsigned long long)(NB_BYTES_GFqv));
                #if HFEvr8
                    /* Clean the last word */
                    V[NB_WORD_GFqv-1]&=HFE_MASKv;
                #endif

                /* Evaluation of the constant, quadratic map with v vinegars */
                evaluateMQSv(F,V,sk);

                #if (HFEDeg>1)
                    /* Evaluation of the linear terms, linear maps with v vinegars */
                    for(i_HFE=0;i_HFE<=HFEDegI;++i_HFE)
                    {
                        vecMatProductv(tmp_n,V,linear_coefs[i_HFE]+NB_WORD_GFqn);
                        HFEADD(F+NB_WORD_GFqn*(((i_HFE*(i_HFE+1))>>1)+1),linear_coefs[i_HFE],tmp_n);
                    }
                #endif
            #endif

            nb_root=chooseRootHFE(DR,F_struct,U);
            if(!nb_root)
            {
                /* fail: retry with an other R1 */
                continue;
            }
            if(nb_root<0)
            {
                /* Error from chooseRootHFE */
                #if HFEv
                    free(F);
                #endif
                return nb_root;
            }

            break;
        } while(1);

        #if HFEv
            /* Add the v bits to DR */
            #if HFEnr
                DR[NB_WORD_GFqn-1]^=V[0]<<HFEnr;
                for(i_HFE=0;i_HFE<(NB_WORD_GFqv-1);++i_HFE)
                {
                    DR[NB_WORD_GFqn+i_HFE]=(V[i_HFE]>>(64-HFEnr))^(V[i_HFE+1]<<HFEnr);
                }
                #if ((NB_WORD_GFqn+NB_WORD_GFqv) == NB_WORD_GFqnv)
                    DR[NB_WORD_GFqn+i_HFE]=V[i_HFE]>>(64-HFEnr);
                #endif
            #else
                for(i_HFE=0;i_HFE<NB_WORD_GFqv;++i_HFE)
                {
                    DR[NB_WORD_GFqn+i_HFE]=V[i_HFE];
                }
            #endif
        #endif

        /* Finally: compute S1||X1 = v * S^(-1) */
        vecMatProductnv(sm+i*NB_WORD_GFqnv,DR,sk+NB_UINT_HFEPOLY);
    }

    #if HFEv
        free(F);
    #endif

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

    /* To generate R_mac */
    derivativeMQS(sm+SIZE_SIGMA_SIGN,t,sk+SIZE_SK);

    tuples[1].inputBitLen=(BitLength)(ACCESS_POINTS<<6);
    #if (K_MAC!=Log2_Tau)
        /* Generation of Z, set of Tau points in GF(2^k) */
        UINT* Z_vec=(UINT*)malloc(SIZE_VEC_POINTS*sizeof(UINT));
        VERIFY_ALLOC_RET(Z_vec);

        /* Use the seed to generate Z */
        GENERATE_Z(sk+ACCESS_SECRET_TREE+SIZE_SECRET_TREE,Z_vec);

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

    #if K_REM
        UINT* mac_pad=(UINT*)malloc(SIZE_MAC*HFEm*sizeof(UINT));
        if(!mac_pad)
        {
            #if (K_MAC!=Log2_Tau)
                free(Z_vec);
            #else
                free(O);
            #endif
            return ERROR_ALLOC;
        }

        for(i=0;i<HFEm;++i)
        {
            padMac(mac_pad+i*SIZE_MAC,sk+SIZE_SK+i*NB_WORD_EQUATION);
        }
    #endif

    /* Compute P_mac(rk) for all rk */ 
    for(k=0;k<PKI_V;++k)
    {
        /* rk */
        #if (K_MAC!=Log2_Tau)
            tmp_k=TAKE_COEF(Z_vec[o[k]/K_QUO],o[k]%K_QUO);
        #else
            tmp_k=TAKE_COEF(O[k/K_QUO],k%K_QUO);
        #endif

        /* Pmac_1(rk), ..., Pmac_m(rk) */
        #if K_REM
            hornerEvaluateGF2k_X_multipoly(sm+ACCESS_POINTS+k*SIZE_VEC_POINTS_m,mac_pad,tmp_k);
        #else
            hornerEvaluateGF2k_X_multipoly(sm+ACCESS_POINTS+k*SIZE_VEC_POINTS_m,sk+SIZE_SK,tmp_k);
        #endif
    }

    #if (K_MAC!=Log2_Tau)
        free(Z_vec);
    #endif
    #if K_REM
        free(mac_pad);
    #endif

    /* Open paths */
    for(k=0;k<PKI_V;++k)
    {
        #if (K_MAC!=Log2_Tau)
            /* Take the index of rk in Z */
            tmp_k=o[k];
        #else
            /* Index of rk == rk */
            tmp_k=TAKE_COEF(O[k/K_QUO],k%K_QUO);
        #endif

        merkleTreeOpenPath(sm+ACCESS_PATH+k*SIZE_PATH,sk+ACCESS_SECRET_TREE,tmp_k);
    }

    #if (K_MAC==Log2_Tau)
        free(O);
    #endif
    return 0;
}


