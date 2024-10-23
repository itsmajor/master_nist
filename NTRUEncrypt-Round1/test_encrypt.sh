#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(443 743 1024)

# build
for sec in "${sec_array[@]}"; do
  cd Reference_Implementation/ntru-pke-$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done

# test
for sec in "${sec_array[@]}"; do
  CIPHER="encrypt NTRUEncrypt-ntru-pke-$sec"
  ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done



#echo "skip NTRUEncrypt-ntru-kem-1024 - 'PQCgenKAT ERROR: crypto_kem_dec returned <-1>' in PQCgenKAT_kem and in PQCgenKAT_kem_dec"

#echo "skip NTRUEncrypt-ntru-pke-443 (Segmentation fault in PQCgenKAT_kem_dec)"
#echo "skip NTRUEncrypt-ntru-pke-443 - reading CT cause errors (Segmentation fault in PQCgenKAT_kem_dec)"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-443"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-443 $OPTIONS
#../_common/script/doKat.sh $doValgrindFull $doValgrindKeygen $doValgrindEnc 0 $CIPHER Reference_Implementation/ntru-pke-443 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

#echo "skip NTRUEncrypt-ntru-pke-743 - reading CT cause errors (Segmentation fault in PQCgenKAT_kem_dec)"
#echo "skip NTRUEncrypt-ntru-pke-743 (Segmentation fault in PQCgenKAT_kem_dec)"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-743"
#../_common/script/doKat.sh $doValgrindFull $doValgrindKeygen $doValgrindEnc 0 $CIPHER Reference_Implementation/ntru-pke-443 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

#echo "skip NTRUEncrypt-ntru-pke-1024 - 'PQCgenKAT ERROR: crypto_encrypt_open returned bad 'mlen': Got <18446744073709551615>, expected <16>'"
#CIPHER="encrypt NTRUEncrypt-ntru-pke-1024"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/ntru-pke-1024 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
