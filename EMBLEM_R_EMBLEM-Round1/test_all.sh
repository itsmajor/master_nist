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

CIPHER="kem EMBLEM-EMBLEM"
../_common/script/doKat.sh $VALGRIND $CIPHER KAT/EMBLEM
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem EMBLEM-R_EMBLEM"
../_common/script/doKat.sh $VALGRIND $CIPHER KAT/R_EMBLEM
../_common/script/doVerifyKat.sh $CIPHER
