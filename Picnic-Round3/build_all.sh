mkdir -p tests

cd Additional_Implementations/picnic3l1-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnic3l1-neon
cd ../..

cd Additional_Implementations/picnic3l3-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnic3l3-neon
cd ../..

cd Additional_Implementations/picnic3l5-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnic3l5-neon
cd ../..

cd Additional_Implementations/picnicl1fs-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl1fs-neon
cd ../..

cd Additional_Implementations/picnicl1full-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl1full-neon
cd ../..

cd Additional_Implementations/picnicl1ur-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl1ur-neon
cd ../..

cd Additional_Implementations/picnicl3fs-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl3fs-neon
cd ../..

cd Additional_Implementations/picnicl3full-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl3full-neon
cd ../..

cd Additional_Implementations/picnicl3ur-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl3ur-neon
cd ../..

cd Additional_Implementations/picnicl5fs-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl5fs-neon
cd ../..

cd Additional_Implementations/picnicl5full-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl5full-neon
cd ../..

cd Additional_Implementations/picnicl5ur-neon
echo "moved to: ${PWD}"
make
mv tests/picnic ../../tests/picnicl5ur-neon
cd ../..

