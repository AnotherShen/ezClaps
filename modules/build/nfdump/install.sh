#Install NFDump with nfpcapd and rebuild shared library cache
cd /tmp
git clone https://github.com/phaag/nfdump.git
cd nfdump
./autogen.sh
./configure --enable-nfpcapd
make
sudo make install
sudo ldconfig