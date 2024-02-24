#! /bin/bash
sec_array=(128 192 256)
kat_dir=../../KAT/encrypt

for sec in ${sec_array[@]}; do
    echo lotus${sec}-encrypt-opt
    make SEC=$sec > /dev/null 2>&1
    ./PQCgenKAT_encrypt
    make SEC=$sec clean > /dev/null 2>&1
    diff -qs PQCencryptKAT_*.rsp ${kat_dir}/lotus${sec}/PQCencryptKAT_*.rsp
    rm PQCencryptKAT_*
done
