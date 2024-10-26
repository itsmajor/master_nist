sudo apt purge valgrind -y
cd ~/workspace
mkdir -p valgrind-bin
cd valgrind-bin
wget https://sourceware.org/pub/valgrind/valgrind-3.23.0.tar.bz2
tar xjvf valgrind-3.23.0.tar.bz2
cd valgrind-3.23.0
./configure
make
sudo make install

cd ..
valgrind ls -l
echo "******* done install_valgrind.sh *****************
