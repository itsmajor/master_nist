doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;
KATTYPE=$5;
CIPHERNAME=$6;
KATPATH=$7;

#next are not mandatory, used by test_all2.sh (pqNTRUsign-Round1)
REPEATS=$8
DEBUG_KAT=$9
DEBUG_KAT_KEYGEN=${10}
DEBUG_KAT_ENC=${11}
DEBUG_KAT_DEC=${12}
#echo "repeats:" $REPEATS $DEBUG_KAT $DEBUG_KAT_KEYGEN $DEBUG_KAT_ENC $DEBUG_KAT_DEC

PARAMCOUNT=7;

if [ $doValgrindFull == "explain4param" ]
  then
    # help text for wrong test_all.sh initialisation
    echo "4 parameter expected for valgrind control (doValgrindFull, doValgrindKeygen, doValgrindEnc, doValgrindDec)"
    echo " doValgrind*: 0 = nothing at all (base KAT is always executed)"
    echo " doValgrind*: 1 = run KAT without valgrind"
    echo " doValgrind*: 2 = run KAT with valgrind"
    echo "example: $ ./test_all.sh 0 1 0 0   --> will do only keygen KAT without valgrind"
    echo "example: $ ./test_all.sh 0 2 0 0   --> will do only keygen KAT with valgrind"
    echo "example: $ ./test_all.sh 0 0 0 0   --> no valgrind, only base KAT executed"
    echo "example: $ ./test_all.sh 0 1 1 1   --> no valgrind, all KAT executed"
    echo "example: $ ./test_all.sh 0 2 2 2   --> will do valgrind keygen, encoding and decoding"
    echo "example: $ ./test_all.sh 0 2 2 1   --> will do valgrind keygen and encoding and no valgrind decoding"
    echo "special: doValgrindFull = 9 will trigger call build_all.sh"
    exit
fi
if [ ! $# -ge $PARAMCOUNT ]
then
  # help text for wrong doKat.sh initialisation
  echo " $PARAMCOUNT parameter expected"
  echo ' doKat.h doValgrindFull doValgrindKeygen doValgrindEnc doValgrindDec KATTYPE CIPHERNAME KATPATH'
  echo " doValgrind*: 0 = nothing at all"
  echo " doValgrind*: 1 = run KAT without valgrind"
  echo " doValgrind*: 2 = run KAT with valgrind"
  echo " example: doKat.sh 0 0 0 0 kem kyber1024 Optimized_Implementation/crypto_kem/kyber1024 "
  echo " example: doKat.sh 0 1 1 1 encrypt kyber1024 Optimized_Implementation/crypto_kem/kyber1024 "
  echo " example: doKat.sh 0 2 2 2 encrypt kyber1024 Optimized_Implementation/crypto_kem/kyber1024 "
  echo " KATPATH without / at the end"
  exit
fi

if [[ -z $DEBUG_KAT ]]; then # -z = ! -n
  #called by (old) test_all.sh, 8th param as debug will be ignored
  REPEATS=10
  DEBUG_KAT=0
  DEBUG_KAT_KEYGEN=0
  DEBUG_KAT_ENC=0
  DEBUG_KAT_DEC=0
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

# PQCgenKAT_kem PQCgenKAT_encrypt PQCgenKAT_sign
KATBINARY=PQCgenKAT_$KATTYPE
# PQCkemKAT PQCencryptKAT PQCsignKAT
OUTPUTFILE=PQC"$KATTYPE"KAT
#echo bin: $KATBINARY output: $OUTPUTFILE

if [ ! -e $KATPATH/$KATBINARY ]
then
    echo "ERROR: PQC binary not found" $KATPATH/$KATBINARY
    exit
fi

cd $KATPATH
echo "  "$(date +'%d.%m.%Y %H:%M:%S.%3N') "start KAT ($KATTYPE):" $CIPHERNAME


# cleanup previous results
rm -f "$OUTPUTFILE"*
rm -f massif.*

if [ $doValgrindFull == "2" ]; then
  echo 'option 2 on $doValgrindFull DEPRECATED'
#  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./"$KATBINARY" $REPEATS $DEBUG_KAT
#  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./"$KATBINARY" $REPEATS $DEBUG_KAT
#  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` "- valgrind "$KATBINARY" done -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi
# repeat for non valgrind time measure
./"$KATBINARY" $REPEATS $DEBUG_KAT
echo " "`date +'%d.%m.%Y %H:%M:%S.%3N'` "- $KATBINARY done (with time measurement) -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`

if [ $doValgrindKeygen == "2" ]; then
  # Heap-only mit pages-as-heap
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --pages-as-heap=yes --heap=yes \
    --stacks=no --max-snapshots=100 --time-unit=i ./"$KATBINARY"_keygen $DEBUG_KAT_KEYGEN
  # Stack-only
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --pages-as-heap=no --heap=no \
    --stacks=yes --max-snapshots=100 --time-unit=i ./"$KATBINARY"_keygen $DEBUG_KAT_KEYGEN
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` "- valgrind "$KATBINARY"_keygen done -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi
if [ $doValgrindKeygen == "1" ]; then
  ./"$KATBINARY"_keygen $DEBUG_KAT_KEYGEN
  echo " "`date +'%d.%m.%Y %H:%M:%S.%3N'` "- "$KATBINARY"_keygen done (no valgrind) -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi


if [ $doValgrindEnc == "2" ]; then
  # Heap-only mit pages-as-heap
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --pages-as-heap=yes --heap=yes \
    --stacks=no --max-snapshots=100 --time-unit=i ./"$KATBINARY"_enc $DEBUG_KAT_ENC
  # Stack-only
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --pages-as-heap=no --heap=no \
    --stacks=yes --max-snapshots=100 --time-unit=i ./"$KATBINARY"_enc $DEBUG_KAT_ENC
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` "- valgrind "$KATBINARY"_enc done -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi
if [ $doValgrindEnc == "1" ]; then
  ./"$KATBINARY"_enc $DEBUG_KAT_ENC
  echo " "`date +'%d.%m.%Y %H:%M:%S.%3N'` "- "$KATBINARY"_enc done (no valgrind) -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi


if [ $doValgrindDec == "2" ]; then
  # Heap-only mit pages-as-heap
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --pages-as-heap=yes --heap=yes \
    --stacks=no --max-snapshots=100 --time-unit=i ./"$KATBINARY"_dec $DEBUG_KAT_DEC
  # Stack-only
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --pages-as-heap=no --heap=no \
    --stacks=yes --max-snapshots=100 --time-unit=i ./"$KATBINARY"_dec $DEBUG_KAT_DEC
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` "- valgrind "$KATBINARY"_dec done -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi
if [ $doValgrindDec == "1" ]; then
  ./"$KATBINARY"_dec $DEBUG_KAT_DEC
  echo " "`date +'%d.%m.%Y %H:%M:%S.%3N'` "- "$KATBINARY"_dec done (no valgrind) -" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
fi


mkdir -p "$LEAVEDIR"/../testresult/$CIPHERNAME
rm "$LEAVEDIR"/../testresult/$CIPHERNAME/* 2> /dev/null
mv "$OUTPUTFILE"* "$LEAVEDIR"/../testresult/$CIPHERNAME
mv massif.* "$LEAVEDIR"/../testresult/$CIPHERNAME/ 2> /dev/null
cd $LEAVEDIR

echo "  "$(date +'%d.%m.%Y %H:%M:%S.%3N') "finish KAT:" $CIPHERNAME "-" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
