#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(640 976 1344)
matrix_array=('AES' 'SHAKE')

for sec in "${sec_array[@]}"; do
  for matrix in "${matrix_array[@]}"; do
    CIPHER="kem FrodoKEM-"$sec"_"$matrix
    ../_common/script/doKat.sh $VALGRIND $CIPHER bin/FrodoKEM-"$sec"_"$matrix" $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done

