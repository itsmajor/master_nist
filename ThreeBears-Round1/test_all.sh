doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;

if [ ! $# -eq 4 ];
then
  ../_common/script/doKat.sh explain4param
  exit
fi

if [ $doValgrindFull -eq 9 ];
then
  ./build_all.sh
fi

VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"

# *****************    here we start Optimized_Implementation      **************************

CIPHER="kem ThreeBears_OI_BabyBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/BabyBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_OI_BabyBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/BabyBearEphem
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_OI_MamaBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/MamaBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_OI_MamaBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/MamaBearEphem
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_OI_PapaBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/PapaBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_OI_PapaBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/PapaBearEphem
../_common/script/doVerifyKat.sh $CIPHER


# *****************    here we start Additional_Implementations - Low_Memory    **************************

CIPHER="kem ThreeBears_Low_Memory_BabyBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/Low_Memory/crypto_kem/BabyBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_Low_Memory_BabyBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/Low_Memory/crypto_kem/BabyBearEphem
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_Low_Memory_MamaBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/Low_Memory/crypto_kem/MamaBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_Low_Memory_MamaBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/Low_Memory/crypto_kem/MamaBearEphem
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_Low_Memory_PapaBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/Low_Memory/crypto_kem/PapaBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_Low_Memory_PapaBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/Low_Memory/crypto_kem/PapaBearEphem
../_common/script/doVerifyKat.sh $CIPHER


# *****************    here we start Additional_Implementations - With_Asm    **************************

CIPHER="kem ThreeBears_With_Asm_BabyBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/With_Asm/crypto_kem/BabyBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_With_Asm_BabyBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/With_Asm/crypto_kem/BabyBearEphem
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_With_Asm_MamaBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/With_Asm/crypto_kem/MamaBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_With_Asm_MamaBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/With_Asm/crypto_kem/MamaBearEphem
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_With_Asm_PapaBear"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/With_Asm/crypto_kem/PapaBear
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem ThreeBears_With_Asm_PapaBearEphem"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/With_Asm/crypto_kem/PapaBearEphem
../_common/script/doVerifyKat.sh $CIPHER

