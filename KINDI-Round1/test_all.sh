doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;

if [ ! $# -eq 4 ];
then
  ../_common/script/doKat.sh explain4param
  exit
fi

if [ $doValgrindFull -eq 9 ];
then
  ./build_all.sh
fi

VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"

sec_array=('256-3-4-2' '256-5-2-2' '512-2-2-2' '512-2-4-1' '512-3-2-1' )
kat_array=('encrypt' 'kem')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    CIPHER="$kat KINDI-"$sec"_$kat"
    ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-256-3-4-2
    ../_common/script/doVerifyKat.sh $CIPHER
  done
done

#CIPHER="encrypt KINDI-256-3-4-2_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-256-3-4-2
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="encrypt KINDI-256-5-2-2_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-256-5-2-2
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="encrypt KINDI-512-2-2-2_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-512-2-2-2
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="encrypt KINDI-512-2-4-1_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-512-2-4-1
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="encrypt KINDI-512-3-2-1_encrypt"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/encrypt/KINDI-512-3-2-1
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem KINDI-256-3-4-2_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/kem/KINDI-256-3-4-2
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem KINDI-256-5-2-2_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/kem/KINDI-256-5-2-2
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem KINDI-512-2-2-2_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/kem/KINDI-512-2-2-2
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem KINDI-512-2-4-1_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/kem/KINDI-512-2-4-1
#../_common/script/doVerifyKat.sh $CIPHER
#
#CIPHER="kem KINDI-512-3-2-1_kem"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/kem/KINDI-512-3-2-1
#../_common/script/doVerifyKat.sh $CIPHER
