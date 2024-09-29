#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

hash_array=('haraka')
#hash_array=('haraka' 'sha256' 'shake256')
sec_array=('128' '192' '256')
letter_array=('f' 's')
variant_array=('robust' 'simple')

for hash in "${hash_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    for letter in "${letter_array[@]}"; do
      for variant in "${variant_array[@]}"; do
        CIPHER="sign sphincs-"$hash"-"$sec$letter"-"$variant
        ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_sign/sphincs-"$hash"-"$sec""$letter"-"$variant" $OPTIONS
        ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
      done
    done
  done
done


