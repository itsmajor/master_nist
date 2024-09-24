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

CIPHER="kem NTRU-Prime-ntrulpr653"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr653
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-ntrulpr761"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr761
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-ntrulpr857"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr857
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-ntrulpr953"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr953
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-ntrulpr1013"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr1013
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-ntrulpr1277"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/ntrulpr1277
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-sntrup653"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup653
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-sntrup761"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup761
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-sntrup857"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup857
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-sntrup953"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup953
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-sntrup1013"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup1013
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRU-Prime-sntrup1277"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/sntrup1277
../_common/script/doVerifyKat.sh $CIPHER
