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
printf "${BLU}ezClaps${NC} - ${AMB}Updating theme...${NC}"
VER=$(lsb_release -r | awk '{print $2}')
if [[ -d "modules/themes/$VER" ]]; then
        sh modules/themes/$VER/install.sh
        printf "${BLU}ezClaps${NC} - ${GRN}Theme updated!${NC}"
else
        printf "${BLU}ezClaps${NC} - ${RED}No theme available!${NC}"
fi

#Set timezone to UTC
printf "${BLU}ezClaps${NC} - ${AMB}Updating timezone...${NC}"
sudo timedatectl set-timezone UTC
printf "${BLU}ezClaps${NC} - ${GRN}Timezone updated to UTC!${NC}"

#Install Python3 & PIP3
printf "${BLU}ezClaps${NC} - ${AMB}Installing Python3 & PIP3...${NC}"
sudo apt update
sudo apt install python3 python3-pip -y
printf "${BLU}ezClaps${NC} - ${GRN}Python3 & PIP3 installed!${NC}"

#Install apt-select and then set mirror
printf "${BLU}ezClaps${NC} - ${AMB}Updating APT mirror...${NC}"
sudo pip3 install apt-select
apt-select -C AU
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo mv sources.list /etc/apt/
printf "${BLU}ezClaps${NC} - ${GRN}APT mirror updated!${NC}"

#Update to pacakge list for new mirror and upgrade system
printf "${BLU}ezClaps${NC} - ${AMB}Upgrading system...${NC}"
sudo apt update
sudo apt upgrade -y
printf "${BLU}ezClaps${NC} - ${GRN}System upgraded!${NC}"

#Install Python2 & PIP2
printf "${BLU}ezClaps${NC} - ${AMB}Installing Python2 & PIP2...${NC}"
sudo apt install python2 python-dev -y
cd /tmp
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py
printf "${BLU}ezClaps${NC} - ${GRN}Python2 & PIP2 installed!${NC}"

#Install NodeJS & NPM
printf "${BLU}ezClaps${NC} - ${AMB}Installing NodeJS & NPM...${NC}"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
printf "${BLU}ezClaps${NC} - ${GRN}NodeJS & NPM installed!${NC}"

#Install APT packages
printf "${BLU}ezClaps${NC} - ${AMB}Installing APT packages...${NC}"
while read line; do
        if [[ ${line:0:1} != \# && $line != "" ]]; then
                sudo DEBIAN_FRONTEND=noninteractive apt -y install $line
        fi
done < apt_packages.txt
printf "${BLU}ezClaps${NC} - ${GRN}APT packages installed!${NC}"

#Run all build scripts
printf "${BLU}ezClaps${NC} - ${AMB}Running build scripts...${NC}"
find modules/build -iname 'install.sh' -exec sh "{}" \;
printf "${BLU}ezClaps${NC} - ${GRN}All build scripts run!${NC}"

#Final message
printf "${BLU}ezClaps${NC} - ${GRN}Setup Complete!${NC}"