#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

nohup ./test_all_resume.sh > ../testresult/sphincs_resume_log.txt 2>&1 &
echo "Daemon sphincs_resume gestartet mit PID $!"
echo "starte tail -f ../testresult/sphincs_resume_log.txt:"
tail -f ../testresult/sphincs_resume_log.txt