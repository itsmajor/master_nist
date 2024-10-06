MAKEOPTION=$1;

#sec_array=(443 743 1024)
sec_array=(443 743)

for sec in "${sec_array[@]}"; do
  cd Reference_Implementation/ntru-kem-$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done

#for sec in "${sec_array[@]}"; do
#  cd Reference_Implementation/ntru-pke-$sec
#  echo "moved to: ${PWD}"
#  make $MAKEOPTION
#  cd ~-
#done