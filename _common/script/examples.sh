echo "read file for examples"
exit 1


############## build_all
sec_array=('VERSION_S' 'VERSION_M' 'VERSION_L')

for sec in "${sec_array[@]}"; do
  cd Reference_Implementation/$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done
############## test_all
sec_array=('VERSION_S' 'VERSION_M' 'VERSION_L')

for sec in "${sec_array[@]}"; do
  CIPHER="sign Gravity_SPHINCS_"$sec
  ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done



############## build_all
sec_array=('256-3-4-2' '256-5-2-2' '512-2-2-2' '512-2-4-1' '512-3-2-1' )
kat_array=('encrypt' 'kem')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    cd Reference_Implementation/$kat/KINDI-$sec
    echo "moved to: ${PWD}"
    make $MAKEOPTION
    cd ~-
  done
done
############## test_all
sec_array=('256-3-4-2' '256-5-2-2' '512-2-2-2' '512-2-4-1' '512-3-2-1' )
kat_array=('encrypt' 'kem')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    CIPHER="$kat KINDI-"$sec"_$kat"
    ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-256-3-4-2
    ../_common/script/doVerifyKat.sh $CIPHER
  done
done


############## build_all
sec_array=(1018 1024 1306 1822 2048 2062)
kat_array=('Encap' 'Enc')
kat2_array=('CCA' 'CPA')

for kat in "${kat_array[@]}"; do
  for kat2 in "${kat2_array[@]}"; do
    cd Optimized_Implementation/NIST/$kat$kat2
    echo "moved to: ${PWD}"
    for sec in "${sec_array[@]}"; do
      make LIMASZ=$sec $MAKEOPTION
    done
    cd ~-
  done
done
############## test_all
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
      ../_common/script/doKat.sh $VALGRIND $CIPHER bin/$kat$kat2/$sec
      ../_common/script/doVerifyKat.sh $CIPHER
    done
  done
done