#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="encrypt KCL-AKCN-MLWE-CCA"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/AKCN-MLWE-CCA/ref $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem KCL-AKCN-MLWE"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/AKCN-MLWE/ref $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem KCL-AKCN-SEC"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/AKCN-SEC/ref $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem KCL-OKCN-MLWE"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/OKCN-MLWE/ref $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem KCL-OKCN-SEC"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/OKCN-SEC/ref $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

