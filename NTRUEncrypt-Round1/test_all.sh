#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem NTRUEncrypt-ntru-kem-443"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-443 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRUEncrypt-ntru-kem-743"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-743 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

#bad mlen in
echo "skip NTRUEncrypt-ntru-kem-1024 - 'PQCgenKAT ERROR: crypto_kem_dec returned <-1>' in PQCgenKAT_kem and in PQCgenKAT_kem_dec"
#CIPHER="kem NTRUEncrypt-ntru-kem-1024"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-kem-1024 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

echo "skip NTRUEncrypt-ntru-pke-443 (Segmentation fault in PQCgenKAT_kem_dec)"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-443"
#../_common/script/doKat.sh $doValgrindFull $doValgrindKeygen $doValgrindEnc 0 $CIPHER Reference_Implementation/ntru-pke-443 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

echo "skip NTRUEncrypt-ntru-pke-743 (Segmentation fault in PQCgenKAT_kem_dec)"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-743"
#../_common/script/doKat.sh $doValgrindFull $doValgrindKeygen $doValgrindEnc 0 $CIPHER Reference_Implementation/ntru-pke-443 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

echo "skip NTRUEncrypt-ntru-pke-1024 - 'PQCgenKAT ERROR: crypto_encrypt_open returned bad 'mlen': Got <18446744073709551615>, expected <16>'"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-1024"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-1024 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
