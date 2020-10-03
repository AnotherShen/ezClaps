#Install SleuthKit (can't use apt due to autopsy)
cd /tmp
git clone https://github.com/sleuthkit/sleuthkit.git
cd sleuthkit
./bootstrap
./configure
sudo make
sudo make install