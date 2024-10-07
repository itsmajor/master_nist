#! /bin/bash

MAKEOPTION=$1;
#312 448 disabled
sec_array=(184)

for sec in "${sec_array[@]}"; do
  cd Optimized_Implementation/amd64/Gui-$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done


#MAKEOPTION=$1;
#
#cd Optimized_Implementation/amd64/
#echo "moved to: ${PWD}"
##modified gui-genkey to generate test/PROJ/ path, default PROJ is 'Gui-184'
#make gui-genkey
#make gui-sign
#make gui-verify
#make PROJ=Gui-312 gui-genkey
#make PROJ=Gui-312 gui-sign
#make PROJ=Gui-312 gui-verify
#make PROJ=Gui-448 gui-genkey
#make PROJ=Gui-448 gui-sign
#make PROJ=Gui-448 gui-verify
#cd ~-
