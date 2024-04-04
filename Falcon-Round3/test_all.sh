cd tests
echo "generate kat Falcon 512 OI"
./kat512fpu

echo "generate kat Falcon 1024 OI"
./kat1024fpu

echo "speed Falcon"
./speed

echo "test Falcon"
./test_falcon

cd ../..