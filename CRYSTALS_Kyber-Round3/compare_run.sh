#!/bin/bash
cd test_compare

MAX=10
SUM=0
echo PQCgenKAT_kem__OI_kyber512
for (( i = 01; i <= MAX; i += 1 ))
do
  let TIME_A=($(date +%s%N)/1)
  ./PQCgenKAT_kem__OI_kyber512
  let TIME_B=($(date +%s%N)/1)
  let DIFF=$TIME_B-$TIME_A
  let DIFF_S=$DIFF/1000000000
  let DIFF_MS=$DIFF%1000000000/1000000
  let DIFF_US=$DIFF%1000000/1000
  if [[ -z "$DIFF_S" ]]; then
      DIFF_S=0
  fi
  let SUM=$SUM+DIFF
  echo "${i}: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us"
done
let AVG=$SUM/$MAX
let DIFF_S=$AVG/1000000000
let DIFF_MS=$AVG%1000000000/1000000
let DIFF_US=$AVG%1000000/1000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us\n"

SUM=0
echo PQCgenKAT_kem__OI_kyber1024
for (( i = 01; i <= MAX; i += 1 ))
do
  let TIME_A=($(date +%s%N)/1)
  ./PQCgenKAT_kem__OI_kyber1024
  let TIME_B=($(date +%s%N)/1)
  let DIFF=$TIME_B-$TIME_A
  let DIFF_S=$DIFF/1000000000
  let DIFF_MS=$DIFF%1000000000/1000000
  let DIFF_US=$DIFF%1000000/1000
  if [[ -z "$DIFF_S" ]]; then
      DIFF_S=0
  fi
  let SUM=$SUM+DIFF
  echo "${i}: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us"
done
let AVG=$SUM/$MAX
let DIFF_S=$AVG/1000000000
let DIFF_MS=$AVG%1000000000/1000000
let DIFF_US=$AVG%1000000/1000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us\n"

SUM=0
echo PQCgenKAT_kem__AI_kyber512
for (( i = 01; i <= MAX; i += 1 ))
do
  let TIME_A=($(date +%s%N)/1)
  ./PQCgenKAT_kem__AI_kyber512
  let TIME_B=($(date +%s%N)/1)
  let DIFF=$TIME_B-$TIME_A
  let DIFF_S=$DIFF/1000000000
  let DIFF_MS=$DIFF%1000000000/1000000
  let DIFF_US=$DIFF%1000000/1000
  if [[ -z "$DIFF_S" ]]; then
      DIFF_S=0
  fi
  let SUM=$SUM+DIFF
  echo "${i}: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us"
done
let AVG=$SUM/$MAX
let DIFF_S=$AVG/1000000000
let DIFF_MS=$AVG%1000000000/1000000
let DIFF_US=$AVG%1000000/1000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us\n"

SUM=0
echo PQCgenKAT_kem__AI_kyber1024
for (( i = 01; i <= MAX; i += 1 ))
do
  let TIME_A=($(date +%s%N)/1)
  ./PQCgenKAT_kem__AI_kyber1024
  let TIME_B=($(date +%s%N)/1)
  let DIFF=$TIME_B-$TIME_A
  let DIFF_S=$DIFF/1000000000
  let DIFF_MS=$DIFF%1000000000/1000000
  let DIFF_US=$DIFF%1000000/1000
  if [[ -z "$DIFF_S" ]]; then
      DIFF_S=0
  fi
  let SUM=$SUM+DIFF
  echo "${i}: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us"
done
let AVG=$SUM/$MAX
let DIFF_S=$AVG/1000000000
let DIFF_MS=$AVG%1000000000/1000000
let DIFF_US=$AVG%1000000/1000
if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi
echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}us\n"

cd ..