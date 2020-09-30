#!/bin/bash
#If running with sudo, error out
if [[ $EUID = 0 ]]; then
        echo "Don't run with sudo!"
        exit 1
fi

#Set timezone to UTC
sudo timedatectl set-timezone UTC

#Update background and terminal if GNOME
XDG=$(echo $XDG_CURRENT_DESKTOP)
if [[ $XDG == *"GNOME"* ]]; then
        sudo wget -O /usr/share/backgrounds/ezclaps.jpg https://i.imgur.com/e5WhMoY.jpg
        gsettings set org.gnome.desktop.background picture-uri 'file:////usr/share/backgrounds/ezclaps.jpg'
        gsettings set org.gnome.desktop.screensaver picture-uri 'file:////usr/share/backgrounds/ezclaps.jpg'

        PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ font 'Monospace 10'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ use-system-font false
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ audible-bell false
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ use-theme-colors 'false'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ use-theme-transparency 'false'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ use-transparent-background 'true'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ background-transparency-percent '10'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ foreground-color 'rgb(170,170,170)'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ background-color 'rgb(0,0,0)'
        gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/ palette "['rgb(0,0,0)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']"
fi

#Install Python3 & PIP3 then select the best mirror for Australia
sudo apt update
sudo apt install python3-pip -y
sudo pip3 install apt-select
apt-select -C AU
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
sudo mv sources.list /etc/apt/

#Update to pacakges based on new mirror and upgrade
sudo apt update
sudo apt upgrade -y

#Install APT packages
while read line; do
        if [[ ${line:0:1} != \# && $line != "" ]]; then
                sudo DEBIAN_FRONTEND=noninteractive apt -y install $line
        fi
done < apt_packages.txt

#Install PIP2
cd /tmp
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py

#Install Volatility using PIP2 (Ubuntu 20.04 doesn't have package due to Python2)
sudo pip2 install pycrypto yara-python distorm3==3.4.4
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/
sudo python2 setup.py install
echo 'alias vol="vol.py"' >> ~/.bashrc
source ~/.bashrc

#Install NFDump with nfpcapd and rebuild shared library cache
cd /tmp
git clone https://github.com/phaag/nfdump.git
cd nfdump
./autogen.sh
./configure --enable-nfpcapd
make
sudo make install
sudo ldconfig

#Install Cyber Chef
echo 'export NODE_OPTIONS=--max_old_space_size=2048' >> ~/.bashrc
cd /tmp
sudo npm install -g grunt-cli
git clone https://github.com/gchq/CyberChef.git
cd CyberChef
npm install
grunt prod
sudo mkdir /opt/cyberchef
sudo mv /tmp/CyberChef/build/prod/* /opt/cyberchef
echo 'alias cyberchef="firefox /opt/cyberchef/index.html &"' >> ~/.bashrc
source ~/.bashrc
ln -s /opt/cyberchef/index.html ~/Desktop/CyberChef

#To-do
#burpsuite
#ghidra
#networkminer
#rekall
#vol3

#Update favourites
if [[ $XDG == *"GNOME"* ]]; then
        gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'wireshark.desktop']"
fi
