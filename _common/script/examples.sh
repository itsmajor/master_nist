echo "read file for examples"
exit 1

############## reduce repeats
OPTIONS_ARRAY=($OPTIONS)

CIPHER="kem BIG_QUAKE_1"
REPEATS=5
if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
  OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
  echo "*** reduced repeats to $REPEATS for $CIPHER ***"
fi

############## reduce repeats for arrays
OPTIONS_ARRAY=($OPTIONS)

sec_array=(184 312 448)
repeat_array=(3 1 1)

i=0
for sec in "${sec_array[@]}"; do
  CIPHER="sign Gui-"$sec
  REPEATS=${repeat_array[i++]}
  if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
    OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
    echo "*** reduced repeats to $REPEATS for $CIPHER ***"
  fi
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/amd64/Gui-$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done

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
    ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-256-3-4-2 $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
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
      ../_common/script/doKat.sh $VALGRIND $CIPHER bin/$kat$kat2/$sec $OPTIONS
      ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
    done
  done
done

############## build_all
hash_array=('haraka' 'sha256' 'shake256')
sec_array=('128' '192' '256')
letter_array=('s' 'f')
variant_array=('simple' 'robust')

for hash in "${hash_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    for letter in "${letter_array[@]}"; do
      for variant in "${variant_array[@]}"; do
        cd Optimized_Implementation/crypto_sign/sphincs-"$hash"-"$sec""$letter"-"$variant"
        echo "moved to: ${PWD}"
        make $MAKEOPTION
        cd ~-
      done
    done
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
      ../_common/script/doKat.sh $VALGRIND $CIPHER bin/$kat$kat2/$sec $OPTIONS
      ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
    done
  done
done