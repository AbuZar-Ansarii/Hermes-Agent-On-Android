#!/bin/bash

# Hermes Agent - One-line installer for Termux (Android)
# Optimized by THEVOIDKERNEL

set -e

# Prevent interactive prompts from breaking the script
export DEBIAN_FRONTEND=noninteractive

# Colors for output
CYN='\033[0;36m'
GRN='\033[0;32m'
RST='\033[0m'

echo -e "${CYN}=====================================================${RST}"
echo -e "${GRN}                THEVOIDKERNEL"
echo -e "${CYN}=====================================================${RST}"

# 1. Update and install system dependencies with "No Questions Asked" flags
echo "📦 Updating system packages..."
pkg update -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
pkg upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

# Install core dependencies including python-psutil to avoid build errors
pkg install -y python python-psutil git clang rust make pkg-config libffi openssl nodejs ripgrep ffmpeg

# 2. Clone or Update repository
if [ -d "hermes-agent" ]; then
    echo "Directory hermes-agent already exists. Updating..."
    cd hermes-agent && git pull && cd ..
else
    git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
fi

cd hermes-agent

# 3. Setup Python virtual environment with system access
echo "Setting up virtual environment..."
rm -rf venv
python -m venv venv --system-site-packages
source venv/bin/activate

# 4. Set Environment
export ANDROID_API_LEVEL="$(getprop ro.build.version.sdk)"
python -m pip install --upgrade pip setuptools wheel

# 5. Install Hermes with Termux support
echo "Installing Hermes Agent..."
python -m pip install -e '.[termux]' -c constraints-termux.txt

# 6. Global Symlink
ln -sf "$PWD/venv/bin/hermes" "$PREFIX/bin/hermes"

echo -e "${GRN}✅ Installation Complete!${RST}"
echo "🔥 Run 'hermes setup' to start."
