#Colour variables for update messages
GRN="\033[1;32m"
AMB="\033[0;33m"
RED="\033[0;31m"
BLU="\033[0;36m"
NC="\033[0m"

#Script starts
echo -e "${BLU}ezClaps${NC} - ${AMB}Starting nfdump build module...${NC}"

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

#Script ends
echo -e "${BLU}ezClaps${NC} - ${GRN}Finished nfdump build module!${NC}"