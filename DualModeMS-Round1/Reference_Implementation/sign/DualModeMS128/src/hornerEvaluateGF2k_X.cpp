#include "hornerEvaluateGF2k_X.hpp"
#include "init.h"

#include <NTL/GF2X.h>
#include <NTL/GF2XFactoring.h>
#include <NTL/GF2E.h>


#define SET_COEF_K(k) \
    tmp_k=TAKE_COEF(F[i],j);\
    GF2XFromBytes(monomX,(unsigned char*)(&tmp_k),(long)NB_BYTES_GF2K_MAC);\
    conv(monom,monomX);\
    SetCoeff(P_NTL,k,monom);



/* To cast one MAC in GF2EX */
void castMACToNTL(GF2EX& P_NTL, const UINT* F)
{
    unsigned int i,j,k=0;
    UINTk tmp_k;

    GF2X f=GF2X(K_MAC,1),monomX;
    SetCoeff(f,0);
    #ifdef __PENTANOMPKI__
        SetCoeff(f,K_1);
        SetCoeff(f,K_2);
    #endif
    SetCoeff(f,K_3);
    GF2E::init(f);
    f.kill();

    GF2E monom;

    P_NTL.SetLength(NB_COEFS_MAC);

    for(i=0;i<MAC_QUO;++i)
    {
        for(j=0;j<K_QUO;++j,++k)
        {
            SET_COEF_K(k);
        }
    }
    #if MAC_REM
        for(j=0;j<MAC_REM;++j,++k)
        {
            SET_COEF_K(k);
        }
    #endif

    monomX.kill();
    clear(monom);
}



#define SET_COEF_K_VEC(k) \
    tmp_k=TAKE_COEF(F[i+h*SIZE_MAC],j);\
    GF2XFromBytes(monomX,(unsigned char*)(&tmp_k),(long)NB_BYTES_GF2K_MAC);\
    conv(monom,monomX);\
    SetCoeff(P_NTL[h],k,monom);


/* To cast m MAC in Vec<GF2EX> */
void castMACToVecmNTL(Vec<GF2EX>& P_NTL, const UINT* F)
{
    unsigned int h,i,j,k;
    UINTk tmp_k;

    GF2X f=GF2X(K_MAC,1),monomX;
    SetCoeff(f,0);
    #ifdef __PENTANOMPKI__
        SetCoeff(f,K_1);
        SetCoeff(f,K_2);
    #endif
    SetCoeff(f,K_3);
    GF2E::init(f);
    f.kill();

    GF2E monom;

    for(h=0;h<HFEm;++h)
    {
        P_NTL[h].SetLength(NB_COEFS_MAC);
        k=0;
        for(i=0;i<MAC_QUO;++i)
        {
            for(j=0;j<K_QUO;++j,++k)
            {
                SET_COEF_K_VEC(k);
            }
        }
        #if MAC_REM
            for(j=0;j<MAC_REM;++j,++k)
            {
                SET_COEF_K_VEC(k);
            }
        #endif
    }

    monomX.kill();
    clear(monom);
}


/* To cast alpha MAC in Vec<GF2EX> */
void castMACToVecalphaNTL(Vec<GF2EX>& P_NTL, const UINT* F)
{
    unsigned int h,i,j,k;
    UINTk tmp_k;

    GF2X f=GF2X(K_MAC,1),monomX;
    SetCoeff(f,0);
    #ifdef __PENTANOMPKI__
        SetCoeff(f,K_1);
        SetCoeff(f,K_2);
    #endif
    SetCoeff(f,K_3);
    GF2E::init(f);
    f.kill();

    GF2E monom;

    for(h=0;h<ALPHA;++h)
    {
        P_NTL[h].SetLength(NB_COEFS_MAC);
        k=0;
        for(i=0;i<MAC_QUO;++i)
        {
            for(j=0;j<K_QUO;++j,++k)
            {
                SET_COEF_K_VEC(k);
            }
        }
        #if MAC_REM
            for(j=0;j<MAC_REM;++j,++k)
            {
                SET_COEF_K_VEC(k);
            }
        #endif
    }

    monomX.kill();
    clear(monom);
}


/*  Input:
        P_NTL a polynomial in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        res an element in GF(2^k), res=P_NTL(X)

    The method of Horner is used to evaluate.
*/
UINTk hornerEvaluateGF2k_X(const GF2EX& P_NTL, UINTk X)
{
    UINTk res=0U;

    GF2E X_NTL,res_NTL;
    GF2X monomX;

    GF2XFromBytes(monomX,(unsigned char*)(&X),(long)NB_BYTES_GF2K_MAC);
    conv(X_NTL,monomX);

    /* Rmac_1(X)*/
    eval(res_NTL,P_NTL,X_NTL);

    conv(monomX,res_NTL);
    BytesFromGF2X((unsigned char*)(&res),monomX,(long)NB_BYTES_GF2K_MAC);

    monomX.kill();
    clear(X_NTL);
    clear(res_NTL);

    return res;
}



/*  Input:
        P_NTL a vector of m polynom in GF(2^k)[X]
        X an element in GF(2^k)

    Output:
        vec_p a vector of m elements in GF(2^k),
        vec_p = P_NTL_1(X),P_NTL_2(X),...,P_NTL_m(X)

    The method of Horner is used to evaluate.
*/
void hornerEvaluateGF2k_X_multipoly(UINT* vec_p, const Vec<GF2EX>& P_NTL, UINTk X)
{
    unsigned int k;
    UINTk res=0U;

    GF2E X_NTL,res_NTL;
    GF2X monomX;

    GF2XFromBytes(monomX,(unsigned char*)(&X),(long)NB_BYTES_GF2K_MAC);
    conv(X_NTL,monomX);

    for(k=0;k<SIZE_VEC_POINTS_m;++k)
    {
        vec_p[k]=0;
    }

    for(k=HFEm-1;k!=(unsigned int)(-1);--k)
    {
        /* Pmac_1(rk), ..., Pmac_m(rk) */
        eval(res_NTL,P_NTL[k],X_NTL);

        conv(monomX,res_NTL);
        BytesFromGF2X((unsigned char*)(&res),monomX,(long)NB_BYTES_GF2K_MAC);

        vec_p[k/K_QUO]^=PUT_COEF(res,k%K_QUO);
    }

    monomX.kill();
    clear(X_NTL);
    clear(res_NTL);
}


