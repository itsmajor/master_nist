cd NTRUEncrypt-Round1/tests

let TIME_A=($(date +%s%N)/1)
#A=$(date --rfc-3339=ns)
#echo A:$A
#echo A:$TIME_A

./ntru-kem-443
./ntru-kem-443

let TIME_B=($(date +%s%N)/1)
#B=$(date --rfc-3339=ns)
#echo $B
#echo B:$TIME_B

let DIFF=$TIME_B-$TIME_A
let DIFF_S=$DIFF/1000000000
let DIFF_MS=$DIFF%1000000000/1000000
#let DIFF_US=$DIFF%1000000/1000
#let DIFF_NS=$DIFF%1000

if [[ -z "$DIFF_S" ]]; then
    DIFF_S=0
fi

#echo diff:$DIFF
echo ${DIFF_S}s ${DIFF_MS}ms
#echo ${DIFF_S}s ${DIFF_MS}ms ${DIFF_US}um ${DIFF_NS} ns

cd ../..
