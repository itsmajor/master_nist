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



#cd tests
#
#echo "test picnic3l1-neon"
#./picnic3l1-neon
#echo "test picnic3l3-neon"
#./picnic3l3-neon
#echo "test picnic3l5-neon"
#./picnic3l5-neon
#echo "test picnicl1fs-neon"
#./picnicl1fs-neon
#echo "test picnicl1full-neon"
#./picnicl1full-neon
#echo "test picnicl1ur-neon"
#./picnicl1ur-neon
#echo "test picnicl3fs-neon"
#./picnicl3fs-neon
#echo "test picnicl3full-neon"
#./picnicl3full-neon
#echo "test picnicl3ur-neon"
#./picnicl3ur-neon
#echo "test picnicl5fs-neon"
#./picnicl5fs-neon
#echo "test picnicl5full-neon"
#./picnicl5full-neon
#echo "test picnicl5ur-neon"
#./picnicl5ur-neon
#
#cd ..
