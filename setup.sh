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
printf "\n${BLU}ezClaps${NC} - ${AMB}Updating theme...${NC}\n\n"
VER=$(lsb_release -r | awk '{print $2}')
if [[ -d "modules/themes/$VER" ]]; then
        sh modules/themes/$VER/install.sh
        printf "\n${BLU}ezClaps${NC} - ${GRN}Theme updated!${NC}\n\n"
else
        printf "\n${BLU}ezClaps${NC} - ${RED}No theme available!${NC}\n\n"
fi

#Set timezone to UTC
printf "\n${BLU}ezClaps${NC} - ${AMB}Updating timezone...${NC}\n\n"
sudo timedatectl set-timezone UTC
printf "\n${BLU}ezClaps${NC} - ${GRN}Timezone updated to UTC!${NC}\n\n"

#Install Python3 & PIP3
printf "\n${BLU}ezClaps${NC} - ${AMB}Installing Python3 & PIP3...${NC}\n\n"
sudo apt update
sudo apt install python3 python3-pip -y
printf "\n${BLU}ezClaps${NC} - ${GRN}Python3 & PIP3 installed!${NC}\n\n"

#Install apt-select and then set mirror
printf "\n${BLU}ezClaps${NC} - ${AMB}Updating APT mirror...${NC}\n\n"
sudo pip3 install apt-select
apt-select -C AU
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo mv sources.list /etc/apt/
printf "\n${BLU}ezClaps${NC} - ${GRN}APT mirror updated!${NC}\n\n"

#Update to pacakge list for new mirror and upgrade system
printf "\n${BLU}ezClaps${NC} - ${AMB}Upgrading system...${NC}\n\n"
sudo apt update
sudo apt upgrade -y
printf "\n${BLU}ezClaps${NC} - ${GRN}System upgraded!${NC}\n\n"

#Install Python2 & PIP2
printf "\n${BLU}ezClaps${NC} - ${AMB}Installing Python2 & PIP2...${NC}\n\n"
sudo apt install python2 python-dev -y
cd /tmp
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py
printf "\n${BLU}ezClaps${NC} - ${GRN}Python2 & PIP2 installed!${NC}\n\n"

#Install NodeJS & NPM
printf "\n${BLU}ezClaps${NC} - ${AMB}Installing NodeJS & NPM...${NC}\n\n"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
printf "\n${BLU}ezClaps${NC} - ${GRN}NodeJS & NPM installed!${NC}\n\n"

#Install APT packages
printf "\n${BLU}ezClaps${NC} - ${AMB}Installing APT packages...${NC}\n\n"
while read line; do
        if [[ ${line:0:1} != \# && $line != "" ]]; then
                sudo DEBIAN_FRONTEND=noninteractive apt -y install $line
        fi
done < apt_packages.txt
printf "\n${BLU}ezClaps${NC} - ${GRN}APT packages installed!${NC}\n\n"

#Run all build scripts
printf "\n${BLU}ezClaps${NC} - ${AMB}Running build scripts...${NC}\n\n"
find modules/build -iname 'install.sh' -exec sh "{}" \;
printf "\n${BLU}ezClaps${NC} - ${GRN}All build scripts run!${NC}\n\n"

#Final message
printf "\n${BLU}ezClaps${NC} - ${GRN}Setup Complete!${NC}\n\n"