#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

mode_array=(1 3 5)
hash_array=('aes' 'sha3')

for mode in "${mode_array[@]}"; do
  for hash in "${hash_array[@]}"; do
    CIPHER="kem bike_"$mode"_"$hash
    ../_common/script/doKat.sh $VALGRIND $CIPHER bin/"$hash"_"$mode" $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done
