#!/bin/bash

sudo mount -a

if [ ! -d "`eval echo ~/workspace/liboqs/build/tests`" ]; then
  echo "*** starting ./prepare_liboqs.sh  (~/workspace/liboqs/build/tests not found)"
  ./prepare_liboqs.sh
  echo "*** done ./prepare_liboqs.sh"
fi

echo "starting liboqs tests"
script -c "~/workspace/liboqs/build/tests/speed_kem" liboqs_kem_speed.log
script -c "~/workspace/liboqs/build/tests/speed_sig" liboqs_sig_speed.log
script -c "python3 run_mem_tomas.py ~/workspace/liboqs/build/tests/test_kem_mem" liboqs_kem_mem.log
script -c "python3 run_mem_tomas.py ~/workspace/liboqs/build/tests/test_sig_mem" liboqs_sig_mem.log

TESTPATH=../../testresult_liboqs_`hostname`_$(date +'%Y.%m.%d_%H.%M')
mkdir -p $TESTPATH
mv liboqs_*.log $TESTPATH/
touch $TESTPATH/host_`hostname`
mv ~/workspace/liboqs/build/tests/test_*_mem.json $TESTPATH/
mv valgrind-out $TESTPATH/

cd ../../
./move_to_majorpc.sh