#! /bin/bash
MAKEOPTION=$1;
sec_array=('256-3-4-2' '256-5-2-2' '512-2-2-2' '512-2-4-1' '512-3-2-1' )
kat_array=('encrypt' 'kem')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    cd Reference_Implementation/$kat/KINDI-$sec
    echo "moved to: ${PWD}"
    make $MAKEOPTION
    cd ../../..
  done
done

#MAKEOPTION=$1;
#
#cd Reference_Implementation/encrypt/KINDI-256-3-4-2
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/encrypt/KINDI-256-5-2-2
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/encrypt/KINDI-512-2-2-2
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/encrypt/KINDI-512-2-4-1
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/encrypt/KINDI-512-3-2-1
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/kem/KINDI-256-3-4-2
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/kem/KINDI-256-5-2-2
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/kem/KINDI-512-2-2-2
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/kem/KINDI-512-2-4-1
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Reference_Implementation/kem/KINDI-512-3-2-1
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
