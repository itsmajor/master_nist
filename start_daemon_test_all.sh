#! /bin/bash

if [ -z $@ ]; then
  PARAM=-v
else
  PARAM=$@
fi

./clean_testresults.sh
mkdir -p testresult
touch testresult/host_`hostname`
echo "test options was '"$@"'" > testresult/test_all.log
./test_all.sh $PARAM >> testresult/test_all.log 2>&1 &
tail -f testresult/test_all.log
