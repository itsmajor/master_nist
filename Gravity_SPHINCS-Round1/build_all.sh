MAKEOPTION=$1;

#disabled  'M' 'L'
sec_array=('S')

for sec in "${sec_array[@]}"; do
  cd Reference_Implementation/VERSION_$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done
