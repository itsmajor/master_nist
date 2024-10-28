#!/bin/bash

LIBOQSPATH=`eval echo ~/workspace/liboqs_backup/build/tests`
TESTRESULTPATH=../../testresult_liboqs_`hostname`_$(date +'%Y.%m.%d_%H.%M')

if [ ! -d "$LIBOQSPATH" ]; then
  echo "*** starting ./prepare_liboqs.sh  ($LIBOQSPATH not found)"
  ./prepare_liboqs.sh
  echo "*** done ./prepare_liboqs.sh"
fi

echo "starting liboqs tests"
script -c "$LIBOQSPATH/speed_kem" liboqs_kem_speed.log
script -c "$LIBOQSPATH/tests/speed_sig" liboqs_sig_speed.log
script -c "python3 run_mem_tomas.py $LIBOQSPATH/test_kem_mem" liboqs_kem_mem.log
script -c "python3 run_mem_tomas.py $LIBOQSPATH/test_sig_mem" liboqs_sig_mem.log

mkdir -p $TESTRESULTPATH
mv liboqs_*.log $TESTRESULTPATH/
touch $TESTRESULTPATH/host_`hostname`
mv $LIBOQSPATH/test_*_mem.json $TESTRESULTPATH/
mv valgrind-out $TESTRESULTPATH/

cd ../../
./move_to_majorpc.sh