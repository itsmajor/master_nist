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
