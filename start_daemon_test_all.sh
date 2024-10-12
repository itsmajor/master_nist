#! /bin/bash

mkdir -p testresult
./test_all.sh -v > testresult/test_all.log 2>&1 &
tail -f testresult/test_all.log
