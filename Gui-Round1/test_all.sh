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
##sec_array=(184 312 448)
#sec_array=(184)
#
#for sec in "${sec_array[@]}"; do
#  CIPHER="sign Gui-"$sec
#  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/amd64/Gui-$sec $DEBUG
#  ../_common/script/doVerifyKat.sh $CIPHER
#done



#cd Optimized_Implementation/amd64/tests/Gui-184
#echo "--------------------"
#echo "test Gui-184 generate key"
##gui-genkey pk_file_name sk_file_name [random_seed_file]
#./gui-genkey pk sk
##gui-sign sk_file_name file_to_be_signed [random_seed_file]
#echo "Gui-184 signing"
#./gui-sign sk gui-genkey > sig
#echo
##gui-verify pk_file_name signature_file_name message_file_name
#./gui-verify pk sig gui-genkey
#cd ../../../..
#
#cd Optimized_Implementation/amd64/tests/Gui-312
#echo "--------------------"
#echo "test Gui-312"
#./gui-genkey pk sk
#echo "Gui-312 signing"
#./gui-sign sk gui-genkey > sig
#./gui-verify pk sig gui-genkey
#cd ../../../..
#
#cd Optimized_Implementation/amd64/tests/Gui-448
#echo "--------------------"
#echo "test Gui-448"
#./gui-genkey pk sk
#echo "Gui-448 signing"
#./gui-sign sk gui-genkey > sig
#./gui-verify pk sig gui-genkey
#cd ../../../..