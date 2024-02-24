#pragma once

#include <stdlib.h>
#include <stdio.h>

#define ONE

#define CRYPTO_OK 0
#define CRYPTO_ERROR 1


#ifdef ONE

#define CRYPTO_m 1003
#define CRYPTO_n 770
#define CRYPTO_k 1
#define CRYPTO_SIGMA 25

#define CRYPTO_t 8
#define CRYPTO_v 32
#define CRYPTO_msg 32

#define CRYPTO_logq 24
#define CRYPTO_RGen 3
#define CRYPTO_MASK 0x0ffffff

#define CRYPTO_KeyLen 32
#define CRYPTO_delta 32


#endif
#ifdef TWO

#define CRYPTO_m 1003
#define CRYPTO_n 770
#define CRYPTO_k 2
#define CRYPTO_SIGMA 25

#define CRYPTO_t 8
#define CRYPTO_v 16
#define CRYPTO_msg 32

#define CRYPTO_logq 24
#define CRYPTO_RGen 3
#define CRYPTO_MASK 0x0ffffff

#define CRYPTO_KeyLen 32
#define CRYPTO_delta 32


#endif

#ifdef THREE

#define CRYPTO_m 1003
#define CRYPTO_n 770
#define CRYPTO_k 4
#define CRYPTO_SIGMA 25

#define CRYPTO_t 8
#define CRYPTO_v 8
#define CRYPTO_msg 32

#define CRYPTO_logq 24
#define CRYPTO_RGen 3
#define CRYPTO_MASK 0x0ffffff

#define CRYPTO_KeyLen 32
#define CRYPTO_delta 32


#endif

#ifdef FOUR

#define CRYPTO_m 1003
#define CRYPTO_n 770
#define CRYPTO_k 8
#define CRYPTO_SIGMA 25

#define CRYPTO_t 8
#define CRYPTO_v 4
#define CRYPTO_msg 32

#define CRYPTO_logq 24
#define CRYPTO_RGen 3
#define CRYPTO_MASK 0x0ffffff

#define CRYPTO_KeyLen 32
#define CRYPTO_delta 32


#endif

#ifdef FIVE

#define CRYPTO_m 1003
#define CRYPTO_n 770
#define CRYPTO_k 16
#define CRYPTO_SIGMA 25

#define CRYPTO_t 8
#define CRYPTO_v 2
#define CRYPTO_msg 32

#define CRYPTO_logq 24
#define CRYPTO_RGen 3
#define CRYPTO_MASK 0x0ffffff

#define CRYPTO_KeyLen 32
#define CRYPTO_delta 32


#endif

#ifdef SIX

#define CRYPTO_m 1003
#define CRYPTO_n 770
#define CRYPTO_k 32
#define CRYPTO_SIGMA 25

#define CRYPTO_t 8
#define CRYPTO_v 1
#define CRYPTO_msg 32

#define CRYPTO_logq 24
#define CRYPTO_RGen 3
#define CRYPTO_MASK 0x0ffffff

#define CRYPTO_KeyLen 32
#define CRYPTO_delta 32


#endif

#define _Module_mat_trans (r, x, row_x, column_x, _i, _j)\
{\
r[row_x*_j + _i] = x[_i*column_x + _j];\
}

#define _Module_mat_add (r, x, y, _i)\
{\
r[_i]=(x[_i]+y[_i])&CRYPTO_MASK;\
}

#define _Module_mat_sub (r, x, y, _i)\
{\
r[_i]=(x[_i]-y[_i])&CRYPTO_MASK;\
}

#define _Module_mat_mul(tmp, x, y)\
{\
tmp+=x*y;\
tmp=tmp&CRYPTO_MASK;\
}


#define _MatTRANS(r, x, row_x, column_x)\
{\
int _i, _j;\
for(_i=0; _i<row_x;_i++)\
{\
for(_j=0; _j<column_x; _j++)\
{\
r[row_x*_j+_i]=x[_i*column_x+_j];\
}\
}\
}

#define _MatADD(r, x, y, row_x, column_x)\
{\
int _i;\
for(_i=0; _i<row_x*column_x;_i++)\
{\
r[_i]=(x[_i]+y[_i])&CRYPTO_MASK;\
}\
}

#define _MatSUB(r, x, y, row_x, column_x)\
{\
int _i;\
for(_i=0; _i<row_x*column_x;_i++)\
{\
r[_i]=(x[_i]-y[_i])&CRYPTO_MASK;\
}\
}


#define _MatMul(r, x, y, row_x, column_x, row_y, column_y)\
{\
int _i, _j, _k, _cnt=0;\
int tmp=0;\
for(_i=0; _i<row_x; _i++)\
{\
for(_k=0; _k<row_y; _k++)\
{\
tmp=0;\
for(_j=0; _j<column_x; _j++)\
{\
tmp += x[_i*column_x + _j] * y[_k*column_y + _j];\
tmp = tmp&CRYPTO_MASK;\
}\
r[_cnt] = tmp;\
_cnt++;\
}\
}\
}

#define _MatMul_add(r, x, y, row_x, column_x, row_y, column_y)\
{\
int _i, _j, _k, _cnt=0;\
int tmp=0;\
for(_i=0; _i<row_x; _i++)\
{\
for(_k=0; _k<row_y; _k++)\
{\
tmp=0;\
for(_j=0; _j<column_x; _j++)\
{\
tmp += x[_i*column_x + _j] * y[_k*column_y + _j];\
tmp = tmp&CRYPTO_MASK;\
}\
r[_cnt] = (r[_cnt]+tmp)&CRYPTO_MASK;\
_cnt++;\
}\
}\
}


#define _dropBits(dx, x)\
{\
int _tmp=0;\
_tmp = x >> (CRYPTO_logq-CRYPTO_t);\
_tmp = _tmp & 0xff;\
dx = _tmp;\
}


typedef struct
{
	int *A;
	int *B;

}_CRYPTO_public_struct;

typedef _CRYPTO_public_struct CRYPTO_public_t[1];

enum CRYPTO_ERR_KEYGEN {

	/* Error codes for block cipher en/decryption */
	CRYPTO_ERR_KEYGEN_ALLOCATION_FAILED = 1000,
	CRYPTO_ERR_KEYGEN_FAILED,
	CRYPTO_ERR_KEYGEN_OUTPUT_NOT_INITIALIZED,

};

enum CRYPTO_ERR_ENC {

	/* Error codes for block cipher en/decryption */
	CRYPTO_ERR_ENC_ALLOCATION_FAILED = 2000,
	CRYPTO_ERR_ENC_NOT_INITIALIZED,
	CRYPTO_ERR_ENC_MSGLEN_ERROR,
	CRYPTO_ERR_ENC_PARAMETER,
	CRYPTO_ERR_ENC_MISSING_MSG,


};