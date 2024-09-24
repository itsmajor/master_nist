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

CIPHER="encrypt lotus128_encrypt"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/lotus128
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt lotus192_encrypt"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/lotus192
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt lotus256_encrypt"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/lotus256
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem lotus128_kem"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/lotus128
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem lotus192_kem"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/lotus192
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem lotus256_kem"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/lotus256
../_common/script/doVerifyKat.sh $CIPHER

