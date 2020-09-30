# ezClaps
Ubuntu 20.04 (18.04 compatible) package installer for incident response.

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
bro
zeek
ghex
oletools
pestudio
ghidra
burpsuite
vol3
rekall
networkminer
```
2. Automate the apt mirror country selector (default: AU)
3. Modularise builds and run them concurrently
