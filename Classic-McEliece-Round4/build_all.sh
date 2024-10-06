MAKEOPTION=$1;

name_array=('mceliece348864' 'mceliece348864f' 'mceliece460896' 'mceliece460896f' 'mceliece6688128' 'mceliece6688128f' 'mceliece6960119' 'mceliece6960119f' 'mceliece8192128' 'mceliece8192128f')

for name in "${name_array[@]}"; do
  cd Additional_Implementations/kem/$name/vec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done
