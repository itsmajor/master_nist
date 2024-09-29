#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem NTRU-Prime-ntrulpr653"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr653 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-ntrulpr761"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr761 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-ntrulpr857"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr857 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-ntrulpr953"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr953 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-ntrulpr1013"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr1013 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-ntrulpr1277"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr1277 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-sntrup653"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup653 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-sntrup761"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup761 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-sntrup857"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup857 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-sntrup953"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup953 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-sntrup1013"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup1013 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Prime-sntrup1277"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup1277 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
