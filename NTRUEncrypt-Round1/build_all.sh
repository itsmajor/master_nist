MAKEOPTION=$1;

#sec_array=(443 743 1024)
sec_array=(443 743)
#kat_array=('kem' 'encrypt')
kat_array=('kem')

for kat in "${kat_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    cd Reference_Implementation/ntru-$kat-$sec
    echo "moved to: ${PWD}"
    make $MAKEOPTION
    cd ~-
  done
done

