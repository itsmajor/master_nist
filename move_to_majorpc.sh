#! /bin/bash

if [ ! -d "/mnt/majorpc/testresult_final/" ]; then
  echo "creating mount to majorpc"
  sudo mkdir -p /mnt/majorpc/testresult_final
  sudo chmod 666 /etc/fstab
  echo -e "\n\n#MajorPC\n//192.168.0.100/testresult_final /mnt/majorpc/testresult_final cifs username=major,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm 0 0" >> /etc/fstab
fi

sudo mount -a

TESTPATH=`ls | grep testresult_`
echo "moving $TESTPATH to majorpc"
mv testresult_* /mnt/majorpc/testresult_final/
echo "move done ($TESTPATH)"