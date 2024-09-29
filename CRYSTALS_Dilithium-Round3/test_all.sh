#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

mode_array=(2 3 5)
hash_array=('AES' 'SHA')

for mode in "${mode_array[@]}"; do
  for hash in "${hash_array[@]}"; do
    CIPHER="sign CRYSTALS-DILITHIUM_mode"$mode"_"$hash
    ../_common/script/doKat.sh $VALGRIND $CIPHER bin/dilithium_MODE"$mode"_"$hash" $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done