#Install Volatility using PIP2 (Ubuntu 20.04 doesn't have package due to Python2)
sudo pip2 install pycrypto yara-python distorm3==3.4.4
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/
sudo python2 setup.py install
echo 'alias vol="vol.py"' >> ~/.bashrc
source ~/.bashrc