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





#cd Reference_Implementation/crypto_sign/dilithium/test
#echo "test dilithium2"
#./test_speed2
#
#echo "test dilithium2aes"
#./test_speed2aes
#
#echo "test dilithium3"
#./test_speed3
#
#echo "test dilithium3aes"
#./test_speed3aes
#
#echo "test dilithium5"
#./test_speed5
#
#echo "test dilithium5aes"
#./test_speed5aes
#
#cd ../../../..