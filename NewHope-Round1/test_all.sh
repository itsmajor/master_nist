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

CIPHER="kem newhope512cca"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope512cca
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem newhope512cpa"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope512cpa
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem newhope1024cca"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope1024cca
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem newhope1024cpa"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/newhope1024cpa
../_common/script/doVerifyKat.sh $CIPHER
