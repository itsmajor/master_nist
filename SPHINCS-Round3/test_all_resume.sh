#! /bin/bash

. ../_common/script/test_all_param.sh "$@"


#this is a resume possibility version:
# no reduced repeats!

hash_array=('haraka' 'sha256' 'shake256')
sec_array=('128' '192' '256')
letter_array=('f' 's')
variant_array=('robust' 'simple')

for hash in "${hash_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    for letter in "${letter_array[@]}"; do
      for variant in "${variant_array[@]}"; do
        CIPHER="sign sphincs-$hash-$sec$letter-$variant"
        DIRNAME="../testresult/sphincs-$hash-$sec$letter-$variant"

        if [ -d "$DIRNAME" ]; then
          echo "Skipping $CIPHER – result directory already exists."
          continue
        fi

        echo "Starting $CIPHER ..."
        ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_sign/sphincs-"$hash"-"$sec$letter"-"$variant" $OPTIONS
        ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
      done
    done
  done
done
echo "done SPHINCS resume"

