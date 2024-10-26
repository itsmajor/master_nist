#! /bin/bash

if [ -z $@ ]; then
  PARAM=-v
else
  PARAM=$@
fi

./clean_testresults.sh
mkdir -p testresult
cp build_all.log testresult/ 2> /dev/null
touch testresult/host_`hostname`
echo "test options was '"$@"'" > testresult/test_all.log
./test_all.sh $PARAM >> testresult/test_all.log 2>&1 &
tail -f testresult/test_all.log
