MAKEOPTION=$1;

cd Optimized_Implementation
echo "moved to: ${PWD} generate lima lib"
make $MAKEOPTION
cd -

cd Optimized_Implementation/NIST/EncapCCA
echo "moved to: ${PWD}"
make SEC=1018 $MAKEOPTION
make SEC=1024 $MAKEOPTION
make SEC=1306 $MAKEOPTION
make SEC=1822 $MAKEOPTION
make SEC=2048 $MAKEOPTION
make SEC=2062 $MAKEOPTION
cd -

cd Optimized_Implementation/NIST/EncapCPA
echo "moved to: ${PWD}"
make SEC=1018 $MAKEOPTION
make SEC=1024 $MAKEOPTION
make SEC=1306 $MAKEOPTION
make SEC=1822 $MAKEOPTION
make SEC=2048 $MAKEOPTION
make SEC=2062 $MAKEOPTION
cd -

# todo
# EncCCA
# EncCPA