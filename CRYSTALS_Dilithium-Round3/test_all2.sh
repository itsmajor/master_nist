#! /bin/bash

DO_CLEAN=0
DO_BUILD=0
DO_VALGRIND=0

# these are options, passed to doKat2.sh in this order (eg. 'doKat2.sh xxx 10 0 0 1 0 ', for 10 repeats and debug KAT_enc)
REPEATS=10 #default
DEBUG_KAT=0
DEBUG_KAT_KEYGEN=0
DEBUG_KAT_ENC=0
DEBUG_KAT_DEC=0

#getopts syntax: letter followed by ':' need argument, space ignored
while getopts "h a:cb r: defgi v" flag
do
    case "${flag}" in
        h) ../_common/script/test_all2_help.sh
           exit;;
        a) VALGRIND=$OPTARG;;
        b) DO_BUILD=1;;
        c) DO_CLEAN=1;;
        r) REPEATS=$OPTARG;;
        d) echo "*** KAT debugging enabled ***"
           DEBUG_KAT=1;;
        e) echo "*** KAT_keygen debugging enabled ***"
           DEBUG_KAT_KEYGEN=1;;
        f) echo "*** KAT_enc debugging enabled ***"
           DEBUG_KAT_ENC=1;;
        g) echo "*** KAT_dec debugging enabled ***"
           DEBUG_KAT_DEC=1;;
        i) echo "*** verifyKat debugging enabled ***"
           DEBUG_VERIFYKAT=1;;
        v) DO_VALGRIND=1;;
        *) echo "use -h for help"
           exit;;
    esac
done

if [[ $DO_VALGRIND -eq 1 ]]; then
  VALGRIND="0 2 2 2"
fi
if [[ -z $VALGRIND ]]; then # -z = ! -n
  echo "*** flag -a not set - using default '0 1 1 1' - no valgrind"
  VALGRIND="0 1 1 1"
fi
#echo "valgrind options:" $VALGRIND
#exit
if [[ $DO_CLEAN -eq 1 ]]; then
  echo "*** do clean"
  ./build_all.sh clean
fi
if [[ $DO_BUILD -eq 1 ]]; then
  echo "*** do build"
  ./build_all.sh
fi

OPTIONS="$REPEATS $DEBUG_KAT $DEBUG_KAT_KEYGEN $DEBUG_KAT_ENC $DEBUG_KAT_DEC"
#echo "options:" $OPTIONS

mode_array=(2 3 5)
hash_array=('AES' 'SHA')

for mode in "${mode_array[@]}"; do
  for hash in "${hash_array[@]}"; do
    CIPHER="sign CRYSTALS-DILITHIUM_mode"$mode"_"$hash
    ../_common/script/doKat.sh $VALGRIND $CIPHER bin/dilithium_MODE"$mode"_"$hash" $OPTIONS
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done





#CIPHER="sign pqNTRUSign-Uniform-1024"
#../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/Uniform-1024 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
#
#
#cd Reference_Implementation/crypto_sign/dilithium/test
#echo "test dilithium2"
#./test_speed2
#
#echo "test dilithium2aes"
#./test_speed2aes
#
#echo "test dilithium3"
#./test_speed3
#
#echo "test dilithium3aes"
#./test_speed3aes
#
#echo "test dilithium5"
#./test_speed5
#
#echo "test dilithium5aes"
#./test_speed5aes
#
#cd ../../../..