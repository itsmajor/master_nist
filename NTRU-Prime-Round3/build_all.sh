mkdir -p tests

NTRUNAME=ntrulpr1013
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=ntrulpr1277
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=ntrulpr653
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=ntrulpr761
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=ntrulpr857
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=ntrulpr953
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=sntrup1013
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=sntrup1277
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=sntrup653
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=sntrup761
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=sntrup857
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

NTRUNAME=sntrup953
cd Optimized_Implementation/kem/${NTRUNAME}
echo "moved to: ${PWD}"
make
mkdir -p ../../../tests/${NTRUNAME}
mv kat ../../../tests/${NTRUNAME}/
cd ../../..

