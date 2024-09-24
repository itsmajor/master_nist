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

CIPHER="kem mceliece348864"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece348864/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece348864f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece348864f/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece460896"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece460896/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece460896f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece460896f/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece6688128"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece6688128/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece6688128f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece348864/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece6960119"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece6960119/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece6960119f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece6960119f/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece8192128"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece8192128/vec
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem mceliece8192128f"
../_common/script/doKat.sh $VALGRIND $CIPHER Additional_Implementations/kem/mceliece8192128f/vec
../_common/script/doVerifyKat.sh $CIPHER
