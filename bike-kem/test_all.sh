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

CIPHER="kem bike-1_sha3"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-1_sha3
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem bike-3_sha3"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-3_sha3
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem bike-5_sha3"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-5_sha3
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem bike-1_aes"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-1_aes
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem bike-3_aes"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-3_aes
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem bike-5_aes"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/bike-5_aes
../_common/script/doVerifyKat.sh $CIPHER
