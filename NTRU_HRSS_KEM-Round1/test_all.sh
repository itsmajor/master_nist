#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem NTRU_HRSS_KEM"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhrss701 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

