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

CIPHER="encrypt AKCN-MLWE-CCA"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/encrypt/AKCN-MLWE-CCA/ref
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem KCL-AKCN-MLWE"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/AKCN-MLWE/ref
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem KCL-AKCN-SEC"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/AKCN-SEC/ref
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem KCL-OKCN-MLWE"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/OKCN-MLWE/ref
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem KCL-OKCN-SEC"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/kem/OKCN-SEC/ref
../_common/script/doVerifyKat.sh $CIPHER

