#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem kyber1024"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber1024 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem kyber1024-90s"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber1024-90s $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem kyber512"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber512 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem kyber512-90s"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber512-90s $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem kyber768"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber768 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem kyber768-90s"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber768-90s $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT