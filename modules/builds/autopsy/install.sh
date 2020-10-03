#Colour variables for update messages
GRN="\033[1;32m"
AMB="\033[0;33m"
RED="\033[0;31m"
BLU="\033[0;36m"
NC="\033[0m"

#Script starts
echo -e "${BLU}ezClaps${NC} - ${AMB}Starting autopsy build module...${NC}"

#Autopsy - Install Photorec Support
sudo apt-get -y install testdisk

#Autopsy - Install HEIC/HEIF Support
sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y build-essential autoconf libtool git-core
sudo apt-get build-dep -y imagemagick libmagickcore-dev libde265 libheif
cd /usr/src/
sudo git clone https://github.com/strukturag/libde265.git
sudo git clone https://github.com/strukturag/libheif.git
cd libde265/
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make install
cd /usr/src/libheif/
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make install
cd /usr/src/
sudo wget https://www.imagemagick.org/download/ImageMagick.tar.gz
sudo tar xf ImageMagick.tar.gz
cd ImageMagick-7*
sudo ./configure --with-heic=yes
sudo make
sudo make install
sudo ldconfig

#Autopsy - Install BellSoft Java 8 & JavaFX 8
cd /tmp
wget http://download.bell-sw.com/java/8u265+1/bellsoft-jdk8u265+1-linux-amd64-full.deb
sudo apt install -y ./bellsoft-jdk8u265+1-linux-amd64-full.deb
echo 'export JAVA_HOME=/usr/lib/jvm/bellsoft-java8-full-amd64' >> ~/.bashrc
source ~/.bashrc
java -version

#Autopsy - Install Java Sleuthkit
cd /tmp
wget https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.10.0/sleuthkit-java_4.10.0-1_amd64.deb
sudo apt install -y ./sleuthkit-java_4.10.0-1_amd64.deb

#Autopsy - Install Autopsy
cd /tmp
wget https://github.com/sleuthkit/autopsy/releases/download/autopsy-4.16.0/autopsy-4.16.0.zip
unzip autopsy-4.16.0.zip
cd autopsy-4.16.0
sh unix_setup.sh
echo 'alias autopsy="./bin/autopsy &"' >> ~/.bashrc
source ~/.bashrc

#Script ends
echo -e "${BLU}ezClaps${NC} - ${GRN}Finished autopsy build module!${NC}"