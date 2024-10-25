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

