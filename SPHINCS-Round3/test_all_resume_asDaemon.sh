#! /bin/bash

if [ -z $@ ]; then
  PARAM=-v
else
  PARAM=$@
fi

nohup ./test_all_resume.sh $PARAM > ../testresult/sphincs_resume_log.txt 2>&1 &
echo "Daemon sphincs_resume gestartet mit PID $!"
echo "starte tail -f ../testresult/sphincs_resume_log.txt:"
tail -f ../testresult/sphincs_resume_log.txt