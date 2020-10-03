#Colour variables for update messages
GRN="\033[1;32m"
AMB="\033[0;33m"
RED="\033[0;31m"
BLU="\033[0;36m"
NC="\033[0m"

#Script starts
echo -e "${BLU}ezClaps${NC} - ${AMB}Starting volatility build module...${NC}"

#Prerequisites
CMD=$(pip2)
VER=$(lsb_release -r | awk '{print $2}')
if [[ $CMD == *"not found"* ]]
    if [[ $VER == "20.04" ]]; then
            sudo add-apt-repository universe
            sudo apt update
            sudo apt install python2 -y
            curl https://bootstrap.pypa.io/get-pip.py --output /tmp/get-pip.py
            sudo python2 /tmp/get-pip.py
    else
            sudo apt install python python-dev python-pip -y
    fi
fi
sudo apt update
sudo apt install git dwarfdump yara zip build-essential -y
sudo pip2 install pycrypto yara-python distorm3==3.4.4

#Install Volatility
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/
sudo python2 setup.py install
echo 'alias vol="vol.py"' >> ~/.bashrc
source ~/.bashrc

#Script ends
echo -e "${BLU}ezClaps${NC} - ${GRN}Finished volatility build module!${NC}"