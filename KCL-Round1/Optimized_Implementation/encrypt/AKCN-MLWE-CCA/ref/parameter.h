#ifndef PARAMETER_H
#define PARAMETER_H

#include <stdint.h>
#include <stdio.h>
#include "myOpenSSL.h"
#include <openssl/sha.h>   
#include <openssl/crypto.h> 
  

#define CLK_TCK 	CLOCKS_PER_SEC
#define	KAPPA 		256

#define LOG2N		8
#define MLWE_N		256
#define MLWE_Q		7681
#define MLWE_ETA	2
#define MLWE_G		32
#define MLWE_T		4
#define MLWE_ELL	3
#define MLWE_M		2

#define LOG2R_IN_REDC			18			/* used in REDC algorithm */
#define MLWE_R_IN_REDC			262144		/* used in REDC algorithm */
#define QPRIME_IN_REDC			7679
#define K_IN_BARRETT_REDUCE		18			/* used in Barrett_reduce algorithm */
#define M_IN_BARRETT_REDUCE		34			/* m should be floor(2^k/q) */

#define K_IN_BUTTERFLY			16


#define	Z_SEED_BYTES				32
#define MATRIX_SEED_BYTES			32
#define	MATRIX_SEED_EXPAND_BYTES	128	
#define NOISE_SEED_BYTES			31
#define NOISE_SEED_EXPAND_BYTES 	128

#define	KEYPAIR_SEED_BYTES		(MATRIX_SEED_BYTES+NOISE_SEED_BYTES+Z_SEED_BYTES)
#define ENC_SEED_BYTES			(MLWE_N/8)

#define MLWE_BASE_FOR_SMALL_POLY       4

#define UNIT_BYTES_IN_TRUNCATED_POLY	10
#define UNIT_BYTES_IN_SMALL_POLY		3
#define UNIT_BYTES_IN_KEY				1
#define UNIT_BYTES_IN_SIGNAL			5


#define TRUNCATED_POLY_BYTES	((MLWE_N/8) * UNIT_BYTES_IN_TRUNCATED_POLY)
#define SMALL_POLY_BYTES		((MLWE_N/8) * UNIT_BYTES_IN_SMALL_POLY)
#define KEY_BYTES				((MLWE_N/8) * UNIT_BYTES_IN_KEY)
#define SIGNAL_BYTES			((MLWE_N/8) * UNIT_BYTES_IN_SIGNAL)

#define TRUNCATED_VECTOR_BYTES	(TRUNCATED_POLY_BYTES * MLWE_ELL)
#define SMALL_VECTOR_BYTES		(SMALL_POLY_BYTES*MLWE_ELL)

#define MAX_MESSAGE_LENGTH 		(65535-MLWE_N/8)

#define CIPHERTEXT_BYTES		(TRUNCATED_VECTOR_BYTES + SIGNAL_BYTES + (32+MAX_MESSAGE_LENGTH+16))
#define PUBLICKEY_BYTES			(TRUNCATED_VECTOR_BYTES + MATRIX_SEED_BYTES)
#define SECRETKEY_BYTES			(SMALL_POLY_BYTES*MLWE_ELL + Z_SEED_BYTES+PUBLICKEY_BYTES)


#define PK_OFFSET_IN_SK				(SMALL_VECTOR_BYTES+Z_SEED_BYTES)

#define Y1_OFFSET_IN_PK				0
#define	MATRIX_SEED_OFFSET_IN_PK	TRUNCATED_VECTOR_BYTES
#define	Y1_OFFSET_IN_SK				(PK_OFFSET_IN_SK+Y1_OFFSET_IN_PK)
#define	MATRIX_SEED_OFFSET_IN_SK	(PK_OFFSET_IN_SK+MATRIX_SEED_OFFSET_IN_PK)

#define	X1_OFFSET_IN_SK				0
#define	Z_SEED_OFFSET_IN_SK			SMALL_VECTOR_BYTES

#define	Y2_OFFSET_IN_C1				0
#define	SIGNAL_OFFSET_IN_C1			TRUNCATED_VECTOR_BYTES
#define	Y2_OFFSET_IN_CT				Y2_OFFSET_IN_C1
#define	SIGNAL_OFFSET_IN_CT			SIGNAL_OFFSET_IN_C1
#define	C1_OFFSET_IN_CT				0
#define	C2_OFFSET_IN_CT				(TRUNCATED_VECTOR_BYTES+SIGNAL_BYTES)
#define C1_BYTES 					(TRUNCATED_VECTOR_BYTES+SIGNAL_BYTES)

#define ModQ(x)			(((x)>=MLWE_Q)?((x)-MLWE_Q):(x))
#define Mod2Q(x)		(((x)>=2*MLWE_Q)?((x)-2*MLWE_Q):(x))

#endif
