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

CIPHER="kem NTRUEncrypt-ntru-kem-443"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-443
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRUEncrypt-ntru-kem-743"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-743
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem NTRUEncrypt-ntru-kem-1024"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-1024
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt NTRUEncrypt-ntru-pke-443"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-443
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt NTRUEncrypt-ntru-pke-743"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-743
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt NTRUEncrypt-ntru-pke-1024"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-1024
../_common/script/doVerifyKat.sh $CIPHER
