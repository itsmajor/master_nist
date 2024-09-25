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

#bad mlen in
echo "skip NTRUEncrypt-ntru-kem-1024 - 'PQCgenKAT ERROR: crypto_kem_dec returned <-1>' in PQCgenKAT_kem and in PQCgenKAT_kem_dec"
#CIPHER="kem NTRUEncrypt-ntru-kem-1024"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-1024
#../_common/script/doVerifyKat.sh $CIPHER

echo "skip NTRUEncrypt-ntru-pke-443 (Segmentation fault in PQCgenKAT_kem_dec)"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-443"
#../_common/script/doKat.sh $doValgrindFull $doValgrindKeygen $doValgrindEnc 0 $CIPHER Reference_Implementation/ntru-pke-443
#../_common/script/doVerifyKat.sh $CIPHER

echo "skip NTRUEncrypt-ntru-pke-743 (Segmentation fault in PQCgenKAT_kem_dec)"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-743"
#../_common/script/doKat.sh $doValgrindFull $doValgrindKeygen $doValgrindEnc 0 $CIPHER Reference_Implementation/ntru-pke-443
#../_common/script/doVerifyKat.sh $CIPHER

echo "skip NTRUEncrypt-ntru-pke-1024 - 'PQCgenKAT ERROR: crypto_encrypt_open returned bad 'mlen': Got <18446744073709551615>, expected <16>'"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-1024"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-1024
#../_common/script/doVerifyKat.sh $CIPHER
