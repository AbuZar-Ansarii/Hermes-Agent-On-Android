#!/data/data/com.termux/files/usr/bin/bash

set -e

# Colors
RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[1;33m'
CYN='\033[0;36m'
RST='\033[0m'

clear

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}                   THEVOIDKERNEL"
echo -e "${CYN}=====================================================${RST}"

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}         HERMES AGENT TERMUX INSTALLER"
echo -e "${CYN}=====================================================${RST}"

echo -e "${YLW}Updating packages...${RST}"
#!/bin/bash

# --- Termux Level Commands ---
pkg update && pkg upgrade -y
pkg install proot-distro -y

# Install and login to Ubuntu
proot-distro install ubuntu

# Use proot-distro login with -- to execute commands inside Ubuntu
proot-distro login ubuntu -- bash -c "
    apt update && apt upgrade -y
    apt install python3 python3-pip python3-venv git curl build-essential nodejs npm -y

    git clone https://github.com/NousResearch/hermes-agent.git
    cd hermes-agent

    pip install --upgrade pip
    pip install -e .
"
echo -e "${CYN}===================================================${RST}"
echo -e "${GRN}      ✅ Hermes Agent installed successfully!"
echo -e "${CYN}===================================================${RST}"

echo "📖 Type 'hermes --help' for more options"
echo ""
echo "💡 Need help? Visit: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android"
echo ""

echo -e "${CYN} 🌐 Run 'hermes gateway' to run deply it${RST}"
echo -e "${CYN} 🔥 Run 'hermes' or 'hermes setup' to start using it ${RST}"
