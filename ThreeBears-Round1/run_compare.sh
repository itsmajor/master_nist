mkdir -p test_compare
cd Additional_Implementations/Low_Memory/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../test_compare/genkat_BabyBear_AI_Low_Memory
cd  ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../test_compare/genkat_BabyBear_AI_With_Asm
cd  ../../../..

cd Optimized_Implementation/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../test_compare/genkat_BabyBear_OI
cd  ../../..

cd test_compare

MAX=10
SUM=0
echo genkat_BabyBear_AI_Low_Memory
for i in 0 .. $MAX
do
  let TIME_A=($(date +%s%N)/1)
  ./genkat_BabyBear_AI_Low_Memory
  let TIME_B=($(date +%s%N)/1)
  let DIFF=$TIME_B-$TIME_A
  let DIFF_S=$DIFF/1000000000
  let DIFF_MS=$DIFF%1000000000/1000000
  if [[ -z "$DIFF_S" ]]; then
      DIFF_S=0
  fi
  let SUM=$SUM+DIFF
  echo ${i}: ${DIFF_S}s ${DIFF_MS}ms
done
let SUM=$SUM/$MAX
let DIFF_S=$SUM/1000000000
let DIFF_MS=$SUM%1000000000/1000000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo SUM: ${DIFF_S}s ${DIFF_MS}ms
SUM=10

echo genkat_BabyBear_AI_With_Asm
let TIME_A=($(date +%s%N)/1)
./genkat_BabyBear_AI_With_Asm
let TIME_B=($(date +%s%N)/1)
let DIFF=$TIME_B-$TIME_A
let DIFF_S=$DIFF/1000000000
let DIFF_MS=$DIFF%1000000000/1000000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo ${DIFF_S}s ${DIFF_MS}ms

echo genkat_BabyBear_OI
let TIME_A=($(date +%s%N)/1)
./genkat_BabyBear_OI
let TIME_B=($(date +%s%N)/1)
let DIFF=$TIME_B-$TIME_A
let DIFF_S=$DIFF/1000000000
let DIFF_MS=$DIFF%1000000000/1000000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo ${DIFF_S}s ${DIFF_MS}ms

cd ..