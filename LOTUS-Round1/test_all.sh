#! /bin/bash

doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;
DEBUG=$5; #not mandatory, any value enable debug log in verifyKat


if [ ! $# -ge 4 ];
then
  ../_common/script/doKat.sh explain4param
  exit
fi

if [ $doValgrindFull -eq 9 ];
then
  ./build_all.sh
fi

VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"

sec_array=(128 192 256)
kat_array=('kem' 'encrypt')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    CIPHER="$kat lotus"$sec"_$kat"
    ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/$kat/lotus$sec $DEBUG
    ../_common/script/doVerifyKat.sh $CIPHER
  done
done

#CIPHER="encrypt lotus128_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/lotus128
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="encrypt lotus192_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/lotus192
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="encrypt lotus256_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/lotus256
#../_common/script/doVerifyKat.sh $CIPHER

#CIPHER="kem lotus128_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/lotus128
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem lotus192_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/lotus192
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem lotus256_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/lotus256
#../_common/script/doVerifyKat.sh $CIPHER

