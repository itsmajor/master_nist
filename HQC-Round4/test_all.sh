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

CIPHER="kem hqc-128"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementation/hqc-128/src
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem hqc-192"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementation/hqc-192/src
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem hqc-256"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementation/hqc-256/src
../_common/script/doVerifyKat.sh $CIPHER
