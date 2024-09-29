#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(1018 1024 1306 1822 2048 2062)
kat_array=('Encap' 'Enc')
kat2_array=('CCA' 'CPA')

for kat in "${kat_array[@]}"; do
  for kat2 in "${kat2_array[@]}"; do
    for sec in "${sec_array[@]}"; do
      KAT_TYPE=${kat//Encap/kem}
      KAT_TYPE=${KAT_TYPE//Enc/encrypt}
      #CIPHER="kem Lima-EncapCCA_1018"
      CIPHER="$KAT_TYPE Lima-"$kat$kat2"_$sec"
      ../_common/script/doKat.sh $VALGRIND $CIPHER bin/$kat$kat2/$sec $OPTIONS
      ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
    done
  done
done

