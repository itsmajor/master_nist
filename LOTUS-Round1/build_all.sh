MAKEOPTION=$1;

cd Optimized_Implementation/encrypt
echo "moved to: ${PWD}"
make SEC=128 PQCgenKAT_encrypt $MAKEOPTION
make SEC=192 PQCgenKAT_encrypt $MAKEOPTION
make SEC=256 PQCgenKAT_encrypt $MAKEOPTION
cd ../..

cd Optimized_Implementation/kem
echo "moved to: ${PWD}"
make SEC=128 $MAKEOPTION
make SEC=192 $MAKEOPTION
make SEC=256 $MAKEOPTION
cd ../..

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