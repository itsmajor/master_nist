#ifndef PARAM_H
#define PARAM_H

/******************************************************************
 * Mutable parameters
 ******************************************************************/
#define KINDI_CPA_N 512
#define KINDI_CPA_LAMBDA 256
#define KINDI_CPA_SHAKEMODE 256

#define KINDI_CPA_LOGQ 14
#define KINDI_CPA_L 2
#define KINDI_CPA_T 1
#define KINDI_CPA_LOG2RSEC 2
#define KINDI_CPA_S1SIZE (512/8)
#define KINDI_CPA_S1BITS 1  //bits per coefficient
/******************************************************************
 * Derived parameters
 ******************************************************************/

#define KINDI_CPA_Q (1<<KINDI_CPA_LOGQ)
#define KINDI_CPA_RSEC (1<<KINDI_CPA_LOG2RSEC)
#define KINDI_CPA_BYTESLOGQ ((int)ceil((KINDI_CPA_LOGQ / 8.0)))
#define KINDI_CPA_BYTESLOGRSECP1 ((int)ceil(((KINDI_CPA_LOG2RSEC+1) / 8.0)))

#define KINDI_CPA_SEEDSIZE (2*KINDI_CPA_LAMBDA/8)
#define KINDI_CPA_HASHSIZE (2*KINDI_CPA_LAMBDA/8)
#define KINDI_CPA_MESSAGESIZE (((KINDI_CPA_L+1)*KINDI_CPA_N*(KINDI_CPA_LOG2RSEC+1)/8) -1)

#define KINDI_CPA_SK_COEFFICIENTBITS (KINDI_CPA_LOG2RSEC+1)
#define KINDI_CPA_NUMBER_CIPHERPOLY (KINDI_CPA_L+1)
#define KINDI_CPA_NUMBER_CIPHERCOEFF (KINDI_CPA_NUMBER_CIPHERPOLY*KINDI_CPA_N)
#define KINDI_CPA_CIPHER_POLYBYTES ((KINDI_CPA_N*(KINDI_CPA_LOGQ))/8)

#define KINDI_CPA_PK_POLYBYTES ((KINDI_CPA_N*(KINDI_CPA_LOGQ-KINDI_CPA_T))/8)
#define KINDI_CPA_SK_POLYBYTES ((KINDI_CPA_N*KINDI_CPA_SK_COEFFICIENTBITS)/8)

#define KINDI_CPA_PUBLICKEYBYTES (KINDI_CPA_L*KINDI_CPA_PK_POLYBYTES + KINDI_CPA_SEEDSIZE)
#define KINDI_CPA_SECRETKEYBYTES (KINDI_CPA_L*KINDI_CPA_SK_POLYBYTES + KINDI_CPA_PUBLICKEYBYTES)
#define KINDI_CPA_CIPHERBYTES (KINDI_CPA_NUMBER_CIPHERPOLY*KINDI_CPA_CIPHER_POLYBYTES)

//####################################################################

#endif
