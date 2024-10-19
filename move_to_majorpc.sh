#! /bin/bash

if [ ! -d "/mnt/majorpc/testresult_final/" ]; then
  echo "creating mount to majorpc"
  sudo mkdir -p /mnt/majorpc/testresult_final
  sudo chmod 666 fstab
  sudo echo -e "\n\n#MajorPC\n//192.168.0.100/testresult_final /mnt/majorpc/testresult_final cifs username=major" >> /etc/fstab
  sudo mount -a
fi

mv testresult_* /mnt/majorpc/testresult_final/ &
echo "move done (testresult to majorpc/testresult_final) "