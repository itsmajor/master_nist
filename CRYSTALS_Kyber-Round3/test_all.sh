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

CIPHER="kem kyber1024"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber1024
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem kyber1024-90s"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber1024-90s
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem kyber512"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber512
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem kyber512-90s"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber512-90s
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem kyber768"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber768
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem kyber768-90s"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/kyber768-90s
../_common/script/doVerifyKat.sh $CIPHER