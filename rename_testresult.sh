#! /bin/bash

cd testresult
if [ -f "test_all.log" ]; then
  cat test_all.log | grep -i -a "error" | grep -v -a "not equal" | grep -i -v -a "known error" | grep -i -v -a "skip " > test_all_errors.log
fi
if [ -f "verifyresult.log" ]; then
  cat verifyresult.log | grep -i -a "error" > verifyresult_errors.log
fi
cd ..



mv testresult testresult_`hostname`_$(date +'%Y.%m.%d_%H.%M')_`echo $@ | sed 's/ /_/g'`
