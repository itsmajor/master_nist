#!/bin/bash

LIBOQSPATH=`eval echo ~/workspace/liboqs/build/tests`
TESTRESULTPATH=../../testresult_liboqs_`hostname`_$(date +'%Y.%m.%d_%H.%M')_fullHeap

if [ ! -d "$LIBOQSPATH" ]; then
  echo "*** starting ./prepare_liboqs.sh  ($LIBOQSPATH not found)"
  ./prepare_liboqs.sh
  echo "*** done ./prepare_liboqs.sh"
fi

echo "starting liboqs tests"
#script -c "$LIBOQSPATH/speed_kem" liboqs_kem_speed.log
#script -c "$LIBOQSPATH/speed_sig" liboqs_sig_speed.log
#script -c "python3 run_mem_modified.py $LIBOQSPATH/test_kem_mem" liboqs_kem_mem.log
#script -c "python3 run_mem_modified.py $LIBOQSPATH/test_sig_mem" liboqs_sig_mem.log

script -c "python3 run_mem_modified_fullHeapOnly.py $LIBOQSPATH/test_kem_mem" liboqs_kem_mem_fullheap.log
script -c "python3 run_mem_modified_fullHeapOnly.py $LIBOQSPATH/test_sig_mem" liboqs_sig_mem_fullheap.log

mkdir -p $TESTRESULTPATH
mv liboqs_*.log $TESTRESULTPATH/
touch $TESTRESULTPATH/host_`hostname`
mv $LIBOQSPATH/test_kem_mem.json $TESTRESULTPATH/test_kem_mem_fullHeap.json
mv $LIBOQSPATH/test_sig_mem.json $TESTRESULTPATH/test_sig_mem_fullHeap.json
mv valgrind-out $TESTRESULTPATH/

cd ../../
./move_to_majorpc.sh