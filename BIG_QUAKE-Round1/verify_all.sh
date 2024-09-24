make -C ../_common/verify/

CIPHER="kem BIG_QUAKE_1"
../_common/script/doVerifyKat.sh $CIPHER debug

CIPHER="kem BIG_QUAKE_3"
../_common/script/doVerifyKat.sh $CIPHER debug

CIPHER="kem BIG_QUAKE_5"
../_common/script/doVerifyKat.sh $CIPHER debug

