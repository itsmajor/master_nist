#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

path_array=('Optimized_Implementation' 'Additional_Implementations/Low_Memory' 'Additional_Implementations/With_Asm')
name_array=('BabyBear' 'BabyBearEphem' 'MamaBear' 'MamaBearEphem' 'PapaBear' 'PapaBearEphem')

for path in "${path_array[@]}"; do
  for name in "${name_array[@]}"; do
    if [ $path == "Optimized_Implementation" ]
      then
      SHORTPATH="OI"
    fi
    if [ $path == "Additional_Implementations/Low_Memory" ]
      then
      SHORTPATH="Low_Memory"
    fi
    if [ $path == "Additional_Implementations/With_Asm" ]
      then
      SHORTPATH="With_Asm"
    fi
    CIPHER="kem ThreeBears_"$SHORTPATH"_"$name
    echo $CIPHER
    ../_common/script/doKat.sh $VALGRIND $CIPHER $path/crypto_kem/$name $OPTION
    ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
  done
done
