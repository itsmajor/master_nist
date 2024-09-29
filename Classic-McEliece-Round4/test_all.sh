#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem mceliece348864"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece348864/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece348864f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece348864f/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece460896"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece460896/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece460896f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece460896f/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece6688128"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece6688128/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece6688128f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece348864/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece6960119"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece6960119/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece6960119f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece6960119f/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece8192128"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece8192128/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem mceliece8192128f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece8192128f/vec $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
