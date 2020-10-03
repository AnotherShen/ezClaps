#Install NFDump with nfpcapd and rebuild shared library cache
sudo apt install pkg-config libtool m4 automake flex bison libpcap-dev libbz2-dev -y
cd /tmp
git clone https://github.com/phaag/nfdump.git
cd nfdump
./autogen.sh
./configure --enable-nfpcapd
make
sudo make install
sudo ldconfig