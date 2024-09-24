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

CIPHER="kem NTRU-Round3-ntruhrss701"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhrss701
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Round3-ntruhps2048509"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhps2048509
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Round3-ntruhps2048677"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhps2048677
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Round3-ntruhps4096821"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhps4096821
../_common/script/doVerifyKat.sh $CIPHER

