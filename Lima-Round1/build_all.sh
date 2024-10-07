#! /bin/bash
MAKEOPTION=$1;

cd Optimized_Implementation/Lib
make
cd ~-

sec_array=(1018 1024 1306 1822 2048 2062)
kat_array=('Encap' 'Enc')
kat2_array=('CCA' 'CPA')

for kat in "${kat_array[@]}"; do
  for kat2 in "${kat2_array[@]}"; do
    cd Optimized_Implementation/NIST/$kat$kat2
    echo "moved to: ${PWD}"
    for sec in "${sec_array[@]}"; do
      make LIMASZ=$sec $MAKEOPTION
    done
    cd ~-
  done
done

#MAKEOPTION=$1;
#
#cd Optimized_Implementation/Lib
#echo "moved to: ${PWD} generate lima lib"
#make $MAKEOPTION
#cd ~-
#
#cd Optimized_Implementation/NIST/EncapCCA
#echo "moved to: ${PWD}"
#make LIMASZ=1018 $MAKEOPTION
#make LIMASZ=1024 $MAKEOPTION
#make LIMASZ=1306 $MAKEOPTION
#make LIMASZ=1822 $MAKEOPTION
#make LIMASZ=2048 $MAKEOPTION
#make LIMASZ=2062 $MAKEOPTION
#cd ~-
#
#cd Optimized_Implementation/NIST/EncapCPA
#echo "moved to: ${PWD}"
#make LIMASZ=1018 $MAKEOPTION
#make LIMASZ=1024 $MAKEOPTION
#make LIMASZ=1306 $MAKEOPTION
#make LIMASZ=1822 $MAKEOPTION
#make LIMASZ=2048 $MAKEOPTION
#make LIMASZ=2062 $MAKEOPTION
#cd ~-
#
#cd Optimized_Implementation/NIST/EncCCA
#echo "moved to: ${PWD}"
#make LIMASZ=1018 $MAKEOPTION
#make LIMASZ=1024 $MAKEOPTION
#make LIMASZ=1306 $MAKEOPTION
#make LIMASZ=1822 $MAKEOPTION
#make LIMASZ=2048 $MAKEOPTION
#make LIMASZ=2062 $MAKEOPTION
#cd ~-
#
#cd Optimized_Implementation/NIST/EncCPA
#echo "moved to: ${PWD}"
#make LIMASZ=1018 $MAKEOPTION
#make LIMASZ=1024 $MAKEOPTION
#make LIMASZ=1306 $MAKEOPTION
#make LIMASZ=1822 $MAKEOPTION
#make LIMASZ=2048 $MAKEOPTION
#make LIMASZ=2062 $MAKEOPTION
#cd ~-
