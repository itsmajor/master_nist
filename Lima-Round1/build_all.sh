MAKEOPTION=$1;

cd Optimized_Implementation/Lib
echo "moved to: ${PWD} generate lima lib"
make $MAKEOPTION
cd ../..

cd Optimized_Implementation/NIST/EncapCCA
echo "moved to: ${PWD}"
make LIMASZ=1018 $MAKEOPTION
make LIMASZ=1024 $MAKEOPTION
make LIMASZ=1306 $MAKEOPTION
make LIMASZ=1822 $MAKEOPTION
make LIMASZ=2048 $MAKEOPTION
make LIMASZ=2062 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/NIST/EncapCPA
echo "moved to: ${PWD}"
make LIMASZ=1018 $MAKEOPTION
make LIMASZ=1024 $MAKEOPTION
make LIMASZ=1306 $MAKEOPTION
make LIMASZ=1822 $MAKEOPTION
make LIMASZ=2048 $MAKEOPTION
make LIMASZ=2062 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/NIST/EncCCA
echo "moved to: ${PWD}"
make LIMASZ=1018 $MAKEOPTION
make LIMASZ=1024 $MAKEOPTION
make LIMASZ=1306 $MAKEOPTION
make LIMASZ=1822 $MAKEOPTION
make LIMASZ=2048 $MAKEOPTION
make LIMASZ=2062 $MAKEOPTION
cd ../../..

cd Optimized_Implementation/NIST/EncCPA
echo "moved to: ${PWD}"
make LIMASZ=1018 $MAKEOPTION
make LIMASZ=1024 $MAKEOPTION
make LIMASZ=1306 $MAKEOPTION
make LIMASZ=1822 $MAKEOPTION
make LIMASZ=2048 $MAKEOPTION
make LIMASZ=2062 $MAKEOPTION
cd ../../..
