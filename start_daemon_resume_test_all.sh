#! /bin/bash

#### warning! ########
# this is only for 32bit prepared!
# read more in  resume_test_all.sh

if [ -z $@ ]; then
  PARAM=-v
else
  PARAM=$@
fi

echo "**** resume_test_all.sh ****" >> testresult/test_all.log
echo "**** resume_test_all.sh ****" >> testresult/verifyresult.log

nohup ./resume_test_all.sh $PARAM >> testresult/test_all.log 2>&1 &

#tail -f testresult/test_all.log
echo "tail verifyresult.log:"
tail -f testresult/verifyresult.log