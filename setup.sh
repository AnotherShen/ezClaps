#!/bin/bash
#If running with sudo, error out
if [[ $EUID = 0 ]]; then
        echo "Don't run with sudo!"
        exit 1
fi

#Colour variables for update messages
GRN='\033[1;32m'
AMB='\033[0;33m'
RED='\033[0;31m'
BLU='\033[0;36m'
NC='\033[0m'

#Run the theme if applicable
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Updating theme...${NC}\n"
VER=$(lsb_release -r | awk '{print $2}')
if [[ -d "modules/themes/$VER" ]]; then
        bash modules/themes/$VER/install.sh
        echo -e "\n${BLU}ezClaps${NC} - ${GRN}Theme updated!${NC}\n"
else
        echo -e "\n${BLU}ezClaps${NC} - ${RED}No theme available!${NC}\n"
fi

#Set timezone to UTC
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Updating timezone...${NC}\n"
sudo timedatectl set-timezone UTC
echo -e "\n${BLU}ezClaps${NC} - ${GRN}Timezone updated to UTC!${NC}\n"

#Install Python3 & PIP3
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Installing Python3 & PIP3...${NC}\n"
sudo apt update
sudo apt install python3 python3-pip -y
echo -e "\n${BLU}ezClaps${NC} - ${GRN}Python3 & PIP3 installed!${NC}\n"

#Install apt-select and then set mirror
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Updating APT mirror...${NC}\n"
sudo pip3 install apt-select
apt-select -C AU
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo mv sources.list /etc/apt/
echo -e "\n${BLU}ezClaps${NC} - ${GRN}APT mirror updated!${NC}\n"

#Update to pacakge list for new mirror and upgrade system
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Upgrading system...${NC}\n"
sudo apt update
sudo apt upgrade -y
echo -e "\n${BLU}ezClaps${NC} - ${GRN}System upgraded!${NC}\n"

#Install Python2 & PIP2
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Installing Python2 & PIP2...${NC}\n"
sudo apt install python2 python-dev -y
cd /tmp
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py
echo -e "\n${BLU}ezClaps${NC} - ${GRN}Python2 & PIP2 installed!${NC}\n"

#Install NodeJS & NPM
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Installing NodeJS & NPM...${NC}\n"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
echo -e "\n${BLU}ezClaps${NC} - ${GRN}NodeJS & NPM installed!${NC}\n"

#Install APT packages
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Installing APT packages...${NC}\n"
while read line; do
        if [[ ${line:0:1} != \# && $line != "" ]]; then
                sudo DEBIAN_FRONTEND=noninteractive apt -y install $line
        fi
done < apt_packages.txt
echo -e "\n${BLU}ezClaps${NC} - ${GRN}APT packages installed!${NC}\n"

#Run all build scripts
echo -e "\n${BLU}ezClaps${NC} - ${AMB}Running build scripts...${NC}\n"
find modules/build -iname 'install.sh' -exec bash "{}" \;
echo -e "\n${BLU}ezClaps${NC} - ${GRN}All build scripts run!${NC}\n"

#Final message
echo -e "\n${BLU}ezClaps${NC} - ${GRN}Setup Complete!${NC}\n"