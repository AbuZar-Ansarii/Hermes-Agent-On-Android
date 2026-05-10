#!/bin/bash

# Hermes Agent - Fixed Termux Installer
# Repository: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android

set -e

# Colors
GRN='\033[0;32m'
CYN='\033[0;36m'
RST='\033[0m'

echo -e "${CYN}================================================${RST}"
echo -e "${GRN}               THEVOIDKERNEL${RST}"
echo -e "${CYN}================================================${RST}"

echo -e "${CYN}================================================${RST}"
echo -e "${GRN}            HERMES AGENT INSTALLER${RST}"
echo -e "${CYN}================================================${RST}"

# Fix 1: Handle apt config prompts
export DEBIAN_FRONTEND=noninteractive
yes 'Y' | pkg upgrade -y 2>/dev/null || true

# Fix 2: Patch Python sysconfig for psutil compatibility
echo -e "${GRN}🔧 Patching Python sysconfig for psutil...${RST}"
_file="$(find $PREFIX/lib/python3.* -name "_sysconfigdata*.py" 2>/dev/null | head -1)"
if [ -f "$_file" ]; then
    cp "$_file" "$_file.backup"
    sed -i 's|-fno-openmp-implicit-rpath||g' "$_file"
    rm -rf $PREFIX/lib/python3.*/__pycache__
    echo -e "${GRN}✅ Python sysconfig patched${RST}"
fi

# Update packages
echo -e "${GRN}📦 Updating packages...${RST}"
pkg update -y
pkg install -y git python clang rust make pkg-config libffi openssl nodejs ripgrep ffmpeg

# Clone repository
echo -e "${GRN}📥 Cloning Hermes Agent...${RST}"
rm -rf hermes-agent 2>/dev/null
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Setup Python virtual environment
python -m venv venv
source venv/bin/activate

# Set Android API level
export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk)"

# Upgrade pip
python -m pip install --upgrade pip setuptools wheel

# Install Hermes with Termux extra (not full all)
echo -e "${GRN}🔧 Installing Hermes Agent (Termux extra)...${RST}"
python -m pip install -e '.[termux]' -c constraints-termux.txt

# Create global symlink
ln -sf "$PWD/venv/bin/hermes" "$PREFIX/bin/hermes"

echo -e "${GRN}✅ Hermes Agent installed successfully!${RST}"
echo -e "${CYN}🔥 Run 'hermes' to start using it${RST}"
echo -e "${CYN}🔧 Run 'hermes setup' for configuration${RST}"
