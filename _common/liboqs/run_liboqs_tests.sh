#!/bin/bash

if [ ! -d "`eval echo ~/workspace/liboqs/build/`" ]; then
  echo "*** starting ./prepare_liboqs.sh because ~/workspace/liboqs/build/ not found"
  ./prepare_liboqs.sh
  echo "*** done ./prepare_liboqs.sh"
fi


python3 run_mem_tomas.py /home/major/workspace/liboqs/build/tests/test_kem_mem

mkdir -p ../../testresult_liboqs_`hostname`_$(date +'%Y.%m.%d_%H.%M')