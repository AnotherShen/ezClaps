#CyberChef - Install CyberChef
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