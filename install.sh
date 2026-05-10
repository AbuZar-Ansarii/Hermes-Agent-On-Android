#!/bin/bash

# Hermes Agent - Termux Installer (Python 3.12 Compatible)
# Repository: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android

set -e

GRN='\033[0;32m'
CYN='\033[0;36m'
RED='\033[0;31m'
RST='\033[0m'

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}         HERMES AGENT - TERMUX INSTALLER P${RST}"
echo -e "${CYN}=====================================================${RST}"

# Fix apt prompts
export DEBIAN_FRONTEND=noninteractive
yes 'Y' | pkg upgrade -y 2>/dev/null || true

# Update packages
echo -e "${GRN}📦 Updating packages...${RST}"
pkg update -y -o Dpkg::Options::--force-confnew 2>/dev/null || true

# CRITICAL: Force Python 3.12 (not 3.13)
echo -e "${GRN}🐍 Installing Python 3.12 (3.13 causes psutil issues)...${RST}"
pkg uninstall python -y 2>/dev/null || true
pkg install -y python=3.12.8

# Hold Python to prevent accidental upgrade
pkg hold python

# Install other dependencies
echo -e "${GRN}📦 Installing other dependencies...${RST}"
pkg install -y git clang rust make pkg-config libffi openssl nodejs ripgrep ffmpeg

# Clone repository
echo -e "${GRN}📥 Cloning Hermes Agent...${RST}"
rm -rf hermes-agent 2>/dev/null
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Setup Python virtual environment
python -m venv venv
source venv/bin/activate

# Set Android API level
export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk 2>/dev/null || echo 24)"

# Upgrade pip
pip install --upgrade pip setuptools wheel

# Install Hermes with Termux extra
echo -e "${GRN}🔧 Installing Hermes Agent...${RST}"
pip install -e '.[termux]' -c constraints-termux.txt

# Create global symlink
ln -sf "$PWD/venv/bin/hermes" "$PREFIX/bin/hermes"

echo -e "${GRN}=====================================================${RST}"
echo -e "${GRN}✅ Hermes Agent installed successfully!${RST}"
echo -e "${GRN}=====================================================${RST}"
echo ""
echo -e "${CYN}🔥 Run 'hermes' to start using it${RST}"
echo -e "${CYN}🔧 Run 'hermes setup' for configuration${RST}"
echo -e "${YEL}⚠️  Python 3.12 is pinned. To keep it: pkg hold python${RST}"
