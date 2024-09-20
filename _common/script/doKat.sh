doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;
KATTYPE=$5;
CIPHERNAME=$6;
KATPATH=$7;

PARAMCOUNT=7;

if [ ! $# -eq $PARAMCOUNT ]
then
  echo " $PARAMCOUNT parameter expected"
  echo " doKat.h doValgrindFull doValgrindKeygen doValgrindEnc doValgrindDec KATTYPE CIPHERNAME KATPATH"
  echo " example: doKat.sh 0 0 0 0 kem kyber1024 Optimized_Implementation/crypto_kem/kyber1024 "
  echo " example: doKat.sh 1 1 1 1 encrypt kyber1024 Optimized_Implementation/crypto_kem/kyber1024 "
  echo " KATPATH without / at the end"
  exit
fi

# remove last / in KATPATH
if [[ $KATPATH = */ ]]
then
  KATPATH=${KATPATH%?}
fi

# remove all char -> //
LEAVEDIR=${KATPATH//[a-zA-Z0-9_-]/}
# add dots for each slash   -> ../../..
LEAVEDIR=${LEAVEDIR//\//\.\.\/}..

# PQCgenKAT_kem PQCgenKAT_encrypt
KATBINARY=PQCgenKAT_$KATTYPE
# PQCkemKAT PQCencryptKAT
OUTPUTFILE=PQC"$KATTYPE"KAT
#echo bin: $KATBINARY output: $OUTPUTFILE

if [ ! -e $KATPATH/$KATBINARY ]
then
    echo "ERROR: PQC binary not found" $KATPATH/$KATBINARY
    exit
fi



cd $KATPATH
echo "test" $CIPHERNAME
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./$KATBINARY
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - $KATBINARY done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./"$KATBINARY"
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./"$KATBINARY"
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./"$KATBINARY"_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./"$KATBINARY"_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEnc == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./"$KATBINARY"_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./"$KATBINARY"_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
fi
if [ $doValgrindDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./"$KATBINARY"_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./"$KATBINARY"_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi

mkdir -p "$LEAVEDIR"/../testresult/$CIPHERNAME
rm "$LEAVEDIR"/../testresult/$CIPHERNAME/* 2> /dev/null
mv "$OUTPUTFILE"* "$LEAVEDIR"/../testresult/$CIPHERNAME
mv massif.* "$LEAVEDIR"/../testresult/$CIPHERNAME/ 2> /dev/null
cd $LEAVEDIR

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $CIPHERNAME
