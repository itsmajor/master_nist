#! /bin/bash
sec_array=(128 192 256)

kat_dir=../../KAT/kem
if [ ! -d $kat_dir ]; then
    mkdir $kat_dir
fi

for sec in ${sec_array[@]}
do
    make SEC=$sec
    ./PQCgenKAT_kem
    make SEC=$sec clean
    dir=${kat_dir}/lotus${sec}
    if [ ! -d $dir ]; then
	mkdir $dir
    fi
    mv PQC* $dir
done
