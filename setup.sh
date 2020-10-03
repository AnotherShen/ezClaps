#!/bin/bash
#If running with sudo, error out
if [[ $EUID = 0 ]]; then
        echo "Don't run with sudo!"
        exit 1
fi

#Colour variables for update messages
GRN="\033[1;32m"
AMB="\033[0;33m"
RED="\033[0;31m"
BLU="\033[0;36m"
NC="\033[0m"

#Run the theme if applicable
echo -e "${BLU}ezClaps${NC} - ${AMB}Updating theme...${NC}"
VER=$(lsb_release -r | awk '{print $2}')
if [[ -d "modules/themes/$VER" ]]; then
        bash modules/themes/$VER/install.sh
        echo -e "${BLU}ezClaps${NC} - ${GRN}Theme updated!${NC}"
else
        echo -e "${BLU}ezClaps${NC} - ${RED}No theme available!${NC}"
fi

#Set timezone to UTC
echo -e "${BLU}ezClaps${NC} - ${AMB}Updating timezone...${NC}"
sudo timedatectl set-timezone UTC
echo -e "${BLU}ezClaps${NC} - ${GRN}Timezone updated to UTC!${NC}"

#Change mirror from US to country code
echo -e "${BLU}ezClaps${NC} - ${AMB}Changing APT mirror country...${NC}"
sudo apt update
sudo apt install curl -y
CN=$(curl ipinfo.io/country | tr '[:upper:]' '[:lower:]')
sudo sed -i "s/us.archive/$CN.archive/g" /etc/apt/sources.list
sudo apt update
echo -e "${BLU}ezClaps${NC} - ${GRN}APT country mirror changed!${NC}"

#Install Python3 & PIP3
echo -e "${BLU}ezClaps${NC} - ${AMB}Installing Python3 & PIP3...${NC}"
sudo apt install python3 python3-pip -y
echo -e "${BLU}ezClaps${NC} - ${GRN}Python3 & PIP3 installed!${NC}"

#Install apt-select and then set mirror
echo -e "${BLU}ezClaps${NC} - ${AMB}Updating to fastest APT mirror...${NC}"
CN=$(curl ipinfo.io/country)
sudo -H pip3 install apt-select
apt-select -C $CN
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo mv sources.list /etc/apt/
sudo apt update
echo -e "${BLU}ezClaps${NC} - ${GRN}Fastest APT mirror updated!${NC}"

#Install Python2 & PIP2
echo -e "${BLU}ezClaps${NC} - ${AMB}Installing Python2 & PIP2...${NC}"
if [[ $VER == "20.04" ]]; then
        sudo add-apt-repository universe
        sudo apt update
        sudo apt install python2 -y
        curl https://bootstrap.pypa.io/get-pip.py --output /tmp/get-pip.py
        sudo python2 /tmp/get-pip.py
else
        sudo apt install python python-dev python-pip -y
fi
echo -e "${BLU}ezClaps${NC} - ${GRN}Python2 & PIP2 installed!${NC}"

#Install NodeJS & NPM
echo -e "${BLU}ezClaps${NC} - ${AMB}Installing NodeJS & NPM...${NC}"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
echo -e "${BLU}ezClaps${NC} - ${GRN}NodeJS & NPM installed!${NC}"

#Update to pacakge list for new mirror and upgrade system
echo -e "${BLU}ezClaps${NC} - ${AMB}Upgrading system...${NC}"
sudo apt update
sudo apt upgrade -y
echo -e "${BLU}ezClaps${NC} - ${GRN}System upgraded!${NC}"

#Install APT packages
echo -e "${BLU}ezClaps${NC} - ${AMB}Installing APT packages...${NC}"
PKGS=""
while read LINE; do
        if [[ ${LINE:0:1} != \# && $LINE != "" ]]; then
                PKGS="${PKGS} ${LINE}"
        fi
done < modules/packages/apt.txt
sudo DEBIAN_FRONTEND=noninteractive apt -y install $PKGS
echo -e "${BLU}ezClaps${NC} - ${GRN}APT packages installed!${NC}"

#Run all build scripts
echo -e "${BLU}ezClaps${NC} - ${AMB}Running build scripts...${NC}"
find modules/builds -iname "install.sh" -exec bash "{}" \;
echo -e "${BLU}ezClaps${NC} - ${GRN}All build scripts run!${NC}"

#Final message
echo -e "${BLU}ezClaps${NC} - ${GRN}Setup Complete!${NC}"