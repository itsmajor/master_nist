#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

sec_array=(128 192 256)
kat_array=('kem' 'encrypt')
repeat_array=(10 5 3)

i=0
for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    CIPHER="$kat lotus"$sec"_$kat"
      REPEATS=${repeat_array[i++]}
      if [ "${OPTIONS_ARRAY[0]}" -gt "$REPEATS" ] && [ "${OPTIONS_ARRAY[5]}" -ne 1 ]; then
        OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
        echo "*** reduced repeats to $REPEATS for $CIPHER ***"
      fi
    ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/$kat/lotus$sec $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
  i=0
done
