#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(128 192 256)
kat_array=('kem' 'encrypt')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    CIPHER="$kat lotus"$sec"_$kat"
    ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/$kat/lotus$sec $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done
