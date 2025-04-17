#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

name_array=('mceliece348864' 'mceliece348864f' 'mceliece460896' 'mceliece460896f' 'mceliece6688128' 'mceliece6688128f' 'mceliece6960119' 'mceliece6960119f' 'mceliece8192128' 'mceliece8192128f')
repeat_array=(10 10 5 10 3 10 3 5 3 5)

for name in "${name_array[@]}"; do
  CIPHER="kem $name"
  REPEATS=${repeat_array[i++]}
  if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
    OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
    echo "*** reduced repeats to $REPEATS for $CIPHER ***"
  fi
  ../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/$name/vec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done