#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

hash_array=('haraka')
sec_array=('128' '192' '256')
letter_array=('f' 's')
variant_array=('robust' 'simple')
repeat_array=(10 10 2 3 10 10 2 2 10 10 2 2)

i=0
for hash in "${hash_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    for letter in "${letter_array[@]}"; do
      for variant in "${variant_array[@]}"; do
        CIPHER="sign sphincs-"$hash"-"$sec$letter"-"$variant
        REPEATS=${repeat_array[i++]}
        if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
          OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
          echo "*** reduced repeats to $REPEATS for $CIPHER ***"
        else
          OPTIONS="${OPTIONS_ARRAY[0]} ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
        fi
        ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_sign/sphincs-"$hash"-"$sec""$letter"-"$variant" $OPTIONS
        ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
      done
    done
  done
done
