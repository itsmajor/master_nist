#! /bin/bash
MAKEOPTION=$1;
path_array=('Optimized_Implementation' 'Additional_Implementations/Low_Memory' 'Additional_Implementations/With_Asm')
name_array=('BabyBear' 'BabyBearEphem' 'MamaBear' 'MamaBearEphem' 'PapaBear' 'PapaBearEphem')

for path in "${path_array[@]}"; do
  for name in "${name_array[@]}"; do
    cd $path/crypto_kem/$name
    echo "moved to: ${PWD}"
    make $MAKEOPTION
    cd ~-
  done
done

#cd Optimized_Implementation/crypto_kem/BabyBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Optimized_Implementation/crypto_kem/BabyBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Optimized_Implementation/crypto_kem/MamaBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Optimized_Implementation/crypto_kem/MamaBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Optimized_Implementation/crypto_kem/PapaBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#cd Optimized_Implementation/crypto_kem/PapaBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../..
#
#
#cd Additional_Implementations/Low_Memory/crypto_kem/BabyBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/Low_Memory/crypto_kem/BabyBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/Low_Memory/crypto_kem/MamaBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/Low_Memory/crypto_kem/MamaBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/Low_Memory/crypto_kem/PapaBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/Low_Memory/crypto_kem/PapaBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#
#
#cd Additional_Implementations/With_Asm/crypto_kem/BabyBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/With_Asm/crypto_kem/BabyBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/With_Asm/crypto_kem/MamaBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/With_Asm/crypto_kem/MamaBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/With_Asm/crypto_kem/PapaBear
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..
#
#cd Additional_Implementations/With_Asm/crypto_kem/PapaBearEphem
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ../../../..