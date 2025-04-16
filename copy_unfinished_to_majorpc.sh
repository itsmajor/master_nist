#! /bin/bash

if [ ! -d "/mnt/majorpc/testresult_final/" ]; then
  echo "creating mount to majorpc"
  sudo mkdir -p /mnt/majorpc/testresult_final
  sudo chmod 666 /etc/fstab
  echo -e "\n\n#MajorPC\n//192.168.0.100/testresult_final /mnt/majorpc/testresult_final cifs username=major,iocharset=utf8,file_mode=0777,dir_mode=0777,noperm 0 0" >> /etc/fstab
fi

sudo mount -a

echo "coping testresult/ to majorpc"
cp -r testresult /mnt/majorpc/testresult_final/testresult_`hostname`_$(date +'%Y.%m.%d_%H.%M')_INCOMPLETE
echo "copy done (testresult/)"