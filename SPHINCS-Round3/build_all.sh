MAKEOPTION=$1;

mkdir -p tests

SPHINCSNAME=sphincs-haraka-128f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-128f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-128s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-128s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-192f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-192f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-192s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-192s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-256f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-256f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-256s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-haraka-256s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-128f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-128f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-128s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-128s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-192f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-192f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-192s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-192s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-256f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-256f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-256s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-sha256-256s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-128f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-128f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-128s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-128s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-192f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-192f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-192s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-192s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-256f-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-256f-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-256s-robust
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..

SPHINCSNAME=sphincs-shake256-256s-simple
cd Optimized_Implementation/crypto_sign/${SPHINCSNAME}
echo "moved to: ${PWD}"
make tests
mv test/fors ../../../tests/fors_${SPHINCSNAME}
mv test/spx ../../../tests/spx_${SPHINCSNAME}
mv test/wots ../../../tests/wots_${SPHINCSNAME}
cd ../../..
