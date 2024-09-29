#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem bike-1_sha3"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-1_sha3 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem bike-3_sha3"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-3_sha3 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem bike-5_sha3"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-5_sha3 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem bike-1_aes"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-1_aes $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem bike-3_aes"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-3_aes $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem bike-5_aes"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-5_aes $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
