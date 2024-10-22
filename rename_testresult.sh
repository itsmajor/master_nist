#! /bin/bash

cd testresult
if [ -f "test_all.log" ]; then
  cat test_all.log | grep -i "error" | grep -v "not equal" | grep -i -v "known error" | grep -i -v "skip " > test_all_errors.log
fi
if [ -f "verifyresult.log" ]; then
  cat verifyresult.log | grep -i error > verifyresult_errors.log
fi
cd ..

mv testresult testresult_`hostname`_$(date +'%Y.%m.%d_%H.%M')_`echo $@ | sed 's/ /_/g'`
