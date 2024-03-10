#include "sign_keypairPKI.h"
#include "encrypt_keypairHFE.h"
#include "one_to_m_equations.h"
#include "hornerEvaluateGF2k_X.h"
#include "merkleTree.h"
#include "init.h"
#include "randombytes.h"
#include <stdlib.h>
#if K_REM
    #include "padMac.h"
#endif

BEGIN_EXTERNC
    #include <libXKCP.a.headers/SimpleFIPS202.h>
    #include <libXKCP.a.headers/KeccakSponge.h>
END_EXTERNC


/*  Input: public and secret keys

    Output: ERROR_ALLOC for errors from malloc/calloc functions, 0 else
*/
int sign_keypairPKI(UINT* pk, UINT* sk)
{
    UINT *original_pk=MALLOC_MQSm, *vec_m_points;
    unsigned int i,j;
    UINTk tmp_k,k=0U;
    int ret;

    VERIFY_ALLOC_RET(original_pk);

    /* Generation of the original pk and sk */
    ret=encrypt_keypairHFE(original_pk,sk);
    if(ret)
    {
        free(original_pk);
        return ret;
    }

    /* Transform one equation in GF(2^m)[x1,...,x_(n+v)], in m equations in
     * GF(2)[x1,...,x_(n+v)] */
    one_to_m_equations(sk+SIZE_SK,original_pk);
    free(original_pk);

    vec_m_points=(UINT*)malloc(SIZE_VEC_POINTS_m*sizeof(UINT));
    VERIFY_ALLOC_RET(vec_m_points);

    /* Generation of P_MAC */
    #if K_REM
        UINT* P_mac=(UINT*)malloc(SIZE_MAC*HFEm*sizeof(UINT));
        if(!P_mac)
        {
            free(vec_m_points);
            return ERROR_ALLOC;
        }

        for(i=0;i<HFEm;++i)
        {
            padMac(P_mac+i*SIZE_MAC,sk+SIZE_SK+i*NB_WORD_EQUATION);
        }
    #endif

    /* Generation of Z, set of Tau points in GF(2^k) */
    #if (K_MAC!=Log2_Tau)
        /* Generation of the seed of size K bits */
        randombytes((unsigned char*)(pk+SIZE_ROOTS_MERKLE),K>>3);
        /* Copy the seed in the secret key */
        for(i=0;i<(K>>6);++i)
        {
            sk[ACCESS_SECRET_TREE+SIZE_SECRET_TREE+i]=\
            pk[SIZE_ROOTS_MERKLE+i];
        }
        UINT* Z_vec=(UINT*)malloc(SIZE_VEC_POINTS*sizeof(UINT));
        if(!Z_vec)
        {
            free(vec_m_points);
            #if K_REM
                free(P_mac);
            #endif
            return ERROR_ALLOC;
        }

        /* Use the seed to generate Z */
        GENERATE_Z(pk+SIZE_ROOTS_MERKLE,Z_vec);
    #endif

    /* Compute P_mac(rk) for Tau points */
    /* The Tau points are 0,1,...,Tau-1 seen like elements of GF2[X] */
    for(i=0;i<Tau_QUO;++i)
    {
        for(j=0;j<K_QUO;++j,++k)
        {
            /* rk */
            #if (K_MAC==Log2_Tau)
                tmp_k=k;
            #else
                tmp_k=TAKE_COEF(Z_vec[i],j);
            #endif

            /* Pmac_1(rk), ..., Pmac_m(rk) */
            #if K_REM
                hornerEvaluateGF2k_X_multipoly(vec_m_points,P_mac,tmp_k);
            #else
                hornerEvaluateGF2k_X_multipoly(vec_m_points,sk+SIZE_SK,tmp_k);
            #endif

            HASH((unsigned char*)(sk+ACCESS_SECRET_TREE+k*(SIZE_DIGEST_UINT)),\
                 (const unsigned char*)vec_m_points,SIZE_VEC_POINTS_m<<3);
        }
    }
    #if Tau_REM
        for(j=0;j<Tau_REM;++j,++k)
        {
            /* rk */
            #if (K_MAC==Log2_Tau)
                tmp_k=k;
            #else
                tmp_k=TAKE_COEF(Z_vec[i],j);
            #endif

            /* Pmac_1(rk), ..., Pmac_m(rk) */
            #if K_REM
                hornerEvaluateGF2k_X_multipoly(vec_m_points,P_mac,tmp_k);
            #else
                hornerEvaluateGF2k_X_multipoly(vec_m_points,sk+SIZE_SK,tmp_k);
            #endif

            HASH((unsigned char*)(sk+ACCESS_SECRET_TREE+k*(SIZE_DIGEST_UINT)),\
                 (const unsigned char*)vec_m_points,SIZE_VEC_POINTS_m<<3);
        }
    #endif

    #if (K_MAC!=Log2_Tau)
        free(Z_vec);
    #endif
    free(vec_m_points);
    #if K_REM
        free(P_mac);
    #endif

    /* Generation of the Merkle tree */
    merkleTreeMerge((unsigned char*)pk,(unsigned char*)(sk+ACCESS_SECRET_TREE));

    return 0;
}
