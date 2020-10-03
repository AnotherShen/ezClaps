# ezClaps
Ubuntu 18.04 & 20.04 package installer for incident response.

![Preview](https://i.imgur.com/GD39b4X.png)

## Verified Ubuntu Versions
1. Ubuntu 20.04
2. Ubuntu 18.04

## Installation
1. Install [Ubuntu 20.04](https://releases.ubuntu.com/)
2. Run the following commands in Terminal
```bash
cd /tmp
wget https://codeload.github.com/0xShen/ezClaps/zip/master
unzip master
cd ezClaps-master
chmod +x setup.sh
./setup.sh
```

## Packages Included
### Languages
```
python2 & pip
python3 & pip3
nodejs & npm
```

### Utilities
```
vim
curl
git
7z
dwarfdump
cyberchef
ngrep
```

### Host Analysis
```
vol.py
yara
libvshadow-utils
ewf-tools
sleuthkit
autopsy
```

### Network Forensics
```
wireshark
tshark
tcpdump
tcpflow
tcpxtract
```

### Metadata
```
exiftool
```

### Credentials
```
john
```

### Reversing
```
radare2
```

## To-Do
1. Add the following packages
```
zeek
ghex
oletools
pestudio
ghidra
burpsuite
vol3
rekall
networkminer
analyzeMFT (pip2)
scdbg
plaso/log2timeline
vscode
regripper
constellation
splunk forwarding agent
```
2. Asyncronsis compiling of build modules
3. Sidebar icons for GUI tools (CyberChef, Autopsy, Burp, etc)
4. Python VENVs (volatility, plaso, vscode, regripper)
