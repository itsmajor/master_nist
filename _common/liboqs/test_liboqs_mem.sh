#!/bin/bash

sudo mount -a

if [ ! -d "`eval echo ~/workspace/liboqs/build/`" ]; then
  echo "*** starting ./prepare_liboqs.sh because ~/workspace/liboqs/build/ not found"
  ./prepare_liboqs.sh
  echo "*** done ./prepare_liboqs.sh"
fi

echo "starting liboqs mem tests - this will take a while (30s+) until first result is shown"
script -c "python3 run_mem_tomas.py ~/workspace/liboqs/build/tests/test_kem_mem" liboqs_mem.log

TESTPATH=../../testresult_liboqs_`hostname`_$(date +'%Y.%m.%d_%H.%M')
mkdir -p $TESTPATH
mv liboqs_mem.log $TESTPATH/
touch $TESTPATH/host_`hostname`
mv ~/workspace/liboqs/build/tests/test_kem_mem.json $TESTPATH/
mv valgrind-out $TESTPATH/

cd ../../
./move_to_majorpc.sh