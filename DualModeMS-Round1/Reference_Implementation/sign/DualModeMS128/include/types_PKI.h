#ifndef _TYPES_PKI_H
#define _TYPES_PKI_H


/****************** TYPES ************************************/


/* This type stores a multivariate quadratic system with m equations in 
GF(2)[x1,...,x_(n+v)]. It is stored like m equations in GF(2)[x1,...,x_(n+v)].*/
typedef UINT* m_mqnv_gf2;
typedef const UINT* cst_m_mqnv_gf2;


/* This type stores a multivariate quadratic system with alpha equations in 
GF(2)[x1,...,x_(n+v)]. It is stored like alpha equations in 
GF(2)[x1,...,x_(n+v)]. */
typedef UINT* alpha_mqnv_gf2;
typedef const UINT* cst_alpha_mqnv_gf2;


/* This type stores a matrix alpha*m in GF(2). */
typedef UINT* M_alpha_m_gf2;
typedef const UINT* cst_M_alpha_m_gf2;
/* to use data[length] */
typedef UINT static_M_alpha_m_gf2;


/* This type stores a vector of alpha elements of GF(2) */
typedef UINT vecalpha_gf2;


/* This type stores a vector of PKI_V elements of GF(2^k) */
/* The elements of GF(2^k) are concatenated in each word, padding with zeros */
typedef UINT* vecv_gf2k;
typedef const UINT* cst_vecv_gf2k;


#endif
