make -C ../_common/verify/

CIPHER="kem Ding_LWE"
../_common/script/doVerifyKat.sh $CIPHER debug

