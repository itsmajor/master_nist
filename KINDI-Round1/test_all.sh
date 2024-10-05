#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=('256-3-4-2' '256-5-2-2' '512-2-2-2' '512-2-4-1' '512-3-2-1' )
kat_array=('encrypt' 'kem')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    CIPHER="$kat KINDI-"$sec"_$kat"
    ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/"$kat"/KINDI-256-3-4-2 $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done
