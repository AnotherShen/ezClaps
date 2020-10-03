#Colour variables for update messages
GRN="\033[1;32m"
AMB="\033[0;33m"
RED="\033[0;31m"
BLU="\033[0;36m"
NC="\033[0m"

#Script starts
echo -e "${BLU}ezClaps${NC} - ${AMB}Starting sleuthkit build module...${NC}"

#Install SleuthKit (can't use apt due to autopsy)
cd /tmp
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit
./bootstrap
./configure
sudo make
sudo make install

#Script ends
echo -e "${BLU}ezClaps${NC} - ${GRN}Finished sleuthkit build module!${NC}"