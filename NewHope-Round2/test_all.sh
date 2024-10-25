#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem newhope512cca"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope512cca $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem newhope512cpa"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope512cpa $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem newhope1024cca"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope1024cca $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem newhope1024cpa"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope1024cpa $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
