echo ""
echo "**********************************************************************************************************************"
echo "**** `pwd` use new test_all2.sh - will execute with defaults  ****"
echo "**********************************************************************************************************************"
echo ""

doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;

if [ ! -z $doValgrindFull ] && [ $doValgrindFull -eq 9 ]; then
  DOBUILD="-b"
fi

if [ $# -eq 4 ]; then
  VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"
  echo "executing:" ./test_all2.sh -a \"$VALGRIND\" $DOBUILD
  ./test_all2.sh -a "$VALGRIND" $DOBUILD
else
  echo "executing:" ./test_all2.sh $DOBUILD
  ./test_all2.sh $DOBUILD
fi


##! /bin/bash
#
#doValgrindFull=$1;
#doValgrindKeygen=$2;
#doValgrindEnc=$3;
#doValgrindDec=$4;
#DEBUG=$5; #not mandatory, any value enable debug log in verifyKat
#
#
#if [ ! $# -ge 4 ];
#then
#  ../_common/script/doKat.sh explain4param
#  exit
#fi
#
#if [ $doValgrindFull -eq 9 ];
#then
#  ./build_all.sh
#fi
#
#VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"
#
#sec_array=('VERSION_S' 'VERSION_M' 'VERSION_L')
#
#for sec in "${sec_array[@]}"; do
#  CIPHER="sign Gravity_SPHINCS_"$sec
#  ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/$sec $DEBUG
#  ../_common/script/doVerifyKat.sh $CIPHER
#done
#
