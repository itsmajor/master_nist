doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;
DEBUG=$5; #not mandatory, any value enable debug log in verifyKat

if [ ! $# -ge 4 ];
then
  ../_common/script/doKat.sh explain4param
  exit
fi

if [ $doValgrindFull -eq 9 ];
then
  ./build_all.sh
fi

VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"

CIPHER="kem BIG_QUAKE_1"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_1 $DEBUG
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem BIG_QUAKE_3"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_3
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem BIG_QUAKE_5"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_5
../_common/script/doVerifyKat.sh $CIPHER
