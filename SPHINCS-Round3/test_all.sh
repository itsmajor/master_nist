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
#echo "test sphincs-haraka-128f-robust"
#./sphincs-haraka-128f-robust
#echo "test sphincs-haraka-128f-simple"
#./sphincs-haraka-128f-simple
#echo "test sphincs-haraka-128s-robust"
#./sphincs-haraka-128s-robust
#echo "test sphincs-haraka-128s-simple"
#./sphincs-haraka-128s-simple
#echo "test sphincs-haraka-192f-robust"
#./sphincs-haraka-192f-robust
#echo "test sphincs-haraka-192f-simple"
#./sphincs-haraka-192f-simple
#echo "test sphincs-haraka-192s-robust"
#./sphincs-haraka-192s-robust
#echo "test sphincs-haraka-192s-simple"
#./sphincs-haraka-192s-simple
#echo "test sphincs-haraka-256f-robust"
#./sphincs-haraka-256f-robust
#echo "test sphincs-haraka-256f-simple"
#./sphincs-haraka-256f-simple
#echo "test sphincs-haraka-256s-robust"
#./sphincs-haraka-256s-robust
#echo "test sphincs-haraka-256s-simple"
#./sphincs-haraka-256s-simple
#echo "test sphincs-sha256-128f-robust"
#./sphincs-sha256-128f-robust
#echo "test sphincs-sha256-128f-simple"
#./sphincs-sha256-128f-simple
#echo "test sphincs-sha256-128s-robust"
#./sphincs-sha256-128s-robust
#echo "test sphincs-sha256-128s-simple"
#./sphincs-sha256-128s-simple
#echo "test sphincs-sha256-192f-robust"
#./sphincs-sha256-192f-robust
#echo "test sphincs-sha256-192f-simple"
#./sphincs-sha256-192f-simple
#echo "test sphincs-sha256-192s-robust"
#./sphincs-sha256-192s-robust
#echo "test sphincs-sha256-192s-simple"
#./sphincs-sha256-192s-simple
#echo "test sphincs-sha256-256f-robust"
#./sphincs-sha256-256f-robust
#echo "test sphincs-sha256-256f-simple"
#./sphincs-sha256-256f-simple
#echo "test sphincs-sha256-256s-robust"
#./sphincs-sha256-256s-robust
#echo "test sphincs-sha256-256s-simple"
#./sphincs-sha256-256s-simple
#echo "test sphincs-shake256-128f-robust"
#./sphincs-shake256-128f-robust
#echo "test sphincs-shake256-128f-simple"
#./sphincs-shake256-128f-simple
#echo "test sphincs-shake256-128s-robust"
#./sphincs-shake256-128s-robust
#echo "test sphincs-shake256-128s-simple"
#./sphincs-shake256-128s-simple
#echo "test sphincs-shake256-192f-robust"
#./sphincs-shake256-192f-robust
#echo "test sphincs-shake256-192f-simple"
#./sphincs-shake256-192f-simple
#echo "test sphincs-shake256-192s-robust"
#./sphincs-shake256-192s-robust
#echo "test sphincs-shake256-192s-simple"
#./sphincs-shake256-192s-simple
#echo "test sphincs-shake256-256f-robust"
#./sphincs-shake256-256f-robust
#echo "test sphincs-shake256-256f-simple"
#./sphincs-shake256-256f-simple
#echo "test sphincs-shake256-256s-robust"
#./sphincs-shake256-256s-robust
#echo "test sphincs-shake256-256s-simple"
#./sphincs-shake256-256s-simple
#
#cd ..
