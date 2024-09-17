MAKEOPTION=$1;

cd Optimized_Implementation/encrypt/lotus128
echo "moved to: ${PWD}"
make SEC=128 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/encrypt/lotus192
echo "moved to: ${PWD}"
make SEC=192 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/encrypt/lotus256
echo "moved to: ${PWD}"
make SEC=256 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/kem/lotus128
echo "moved to: ${PWD}"
make SEC=128 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/kem/lotus192
echo "moved to: ${PWD}"
make SEC=192 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/kem/lotus256
echo "moved to: ${PWD}"
make SEC=256 $MAKEOPTION
cd ../../..

##! /bin/bash
#sec_array=(128 192 256)
#kat_dir=../../KAT/encrypt
#
#for sec in ${sec_array[@]}; do
#    echo lotus${sec}-encrypt-opt
#    make SEC=$sec > /dev/null 2>&1
#    ./PQCgenKAT_encrypt
#    make SEC=$sec clean > /dev/null 2>&1
#    diff -qs PQCencryptKAT_*.rsp ${kat_dir}/lotus${sec}/PQCencryptKAT_*.rsp
#    rm PQCencryptKAT_*
#done