#! /bin/bash

if [ -z $@ ]; then
  PARAM=-v
else
  PARAM=$@
fi

echo "**** resume_test_all.sh ****" >> testresult/test_all.log

./resume_test_all.sh $PARAM >> testresult/test_all.log 2>&1 &

#tail -f testresult/test_all.log
echo "tail verifyresult.log:"
tail -f testresult/verifyresult.log