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

CIPHER="kem Odd_Manhattan_128"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/128
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Odd_Manhattan_192"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/192
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Odd_Manhattan_256"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/256
../_common/script/doVerifyKat.sh $CIPHER

