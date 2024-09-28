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

CIPHER="kem Ding_LWE"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation $DEBUG
../_common/script/doVerifyKat.sh $CIPHER
