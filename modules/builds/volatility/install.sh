#Prerequisites
CMD=$(pip2)
VER=$(lsb_release -r | awk '{print $2}')
if [[ $CMD == *"not found"* ]]
    if [[ $VER == "20.04" ]]; then
            sudo apt install python2 python-dev -y
            curl https://bootstrap.pypa.io/get-pip.py --output /tmp/get-pip.py
            sudo python2 /tmp/get-pip.py
    else
            sudo apt install python python-dev python-pip -y
    fi
fi
sudo apt install git dwarfdump yara zip build-essential -y
sudo pip2 install pycrypto yara-python distorm3==3.4.4

#Install Volatility
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility/
sudo python2 setup.py install
echo 'alias vol="vol.py"' >> ~/.bashrc
source ~/.bashrc