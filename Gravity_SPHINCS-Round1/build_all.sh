MAKEOPTION=$1;

sec_array=('VERSION_S' 'VERSION_M' 'VERSION_L')

for sec in "${sec_array[@]}"; do
  cd Reference_Implementation/$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done
