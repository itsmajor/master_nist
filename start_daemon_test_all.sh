#! /bin/bash

if [ -z $@ ]; then
  PARAM=-v
else
  PARAM=$@
fi

mkdir -p testresult
touch testresult/host_`hostname`
./test_all.sh $PARAM > testresult/test_all.log 2>&1 &
tail -f testresult/test_all.log
