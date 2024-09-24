echo this code is deprecated

##!/bin/bash
#cd test_compare
#
#MAX=10
#SUM=0
#echo genkat_BabyBear_AI_Low_Memory
#for (( i = 01; i <= MAX; i += 1 ))
#do
#  let TIME_A=($(date +%s%N)/1)
#  ./genkat_BabyBear_AI_Low_Memory
#  let TIME_B=($(date +%s%N)/1)
#  let DIFF=$TIME_B-$TIME_A
#  let DIFF_S=$DIFF/1000000000
#  let DIFF_MS=$DIFF%1000000000/1000000
#  if [[ -z "$DIFF_S" ]]; then
#      DIFF_S=0
#  fi
#  let SUM=$SUM+DIFF
#  echo ${i}: ${DIFF_S}s ${DIFF_MS}ms
#done
#let AVG=$SUM/$MAX
#let DIFF_S=$AVG/1000000000
#let DIFF_MS=$AVG%1000000000/1000000
#if [[ -z "$DIFF_S" ]]; then
#    DIFF_S=0
#fi
#echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms \n"
#
#
#SUM=0
#echo genkat_BabyBear_AI_With_Asm
#for (( i = 01; i <= MAX; i += 1 ))
#do
#  let TIME_A=($(date +%s%N)/1)
#  ./genkat_BabyBear_AI_With_Asm
#  let TIME_B=($(date +%s%N)/1)
#  let DIFF=$TIME_B-$TIME_A
#  let DIFF_S=$DIFF/1000000000
#  let DIFF_MS=$DIFF%1000000000/1000000
#  if [[ -z "$DIFF_S" ]]; then
#      DIFF_S=0
#  fi
#  let SUM=$SUM+DIFF
#  echo ${i}: ${DIFF_S}s ${DIFF_MS}ms
#done
#let AVG=$SUM/$MAX
#let DIFF_S=$AVG/1000000000
#let DIFF_MS=$AVG%1000000000/1000000
#if [[ -z "$DIFF_S" ]]; then
#    DIFF_S=0
#fi
#echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms \n"
#
#SUM=0
#echo genkat_BabyBear_OI
#for (( i = 01; i <= MAX; i += 1 ))
#do
#  let TIME_A=($(date +%s%N)/1)
#  ./genkat_BabyBear_OI
#  let TIME_B=($(date +%s%N)/1)
#  let DIFF=$TIME_B-$TIME_A
#  let DIFF_S=$DIFF/1000000000
#  let DIFF_MS=$DIFF%1000000000/1000000
#  if [[ -z "$DIFF_S" ]]; then
#      DIFF_S=0
#  fi
#  let SUM=$SUM+DIFF
#  echo ${i}: ${DIFF_S}s ${DIFF_MS}ms
#done
#let AVG=$SUM/$MAX
#let DIFF_S=$AVG/1000000000
#let DIFF_MS=$AVG%1000000000/1000000
#if [[ -z "$DIFF_S" ]]; then
#    DIFF_S=0
#fi
#echo -e "AVG: ${DIFF_S}s ${DIFF_MS}ms \n"
#
#
#cd ..