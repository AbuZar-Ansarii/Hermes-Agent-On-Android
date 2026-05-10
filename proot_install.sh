#!/bin/bash

# Hermes Agent - Proot-Distro Ubuntu Installer for Termux
# Repository: https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android
# 
# This script:
# 1. Installs proot-distro in Termux
# 2. Sets up Ubuntu container
# 3. Installs Hermes Agent inside Ubuntu
# 4. Creates convenient aliases to run Hermes from Termux

set -e

# Colors
GRN='\033[0;32m'
CYN='\033[0;36m'
YEL='\033[0;33m'
RED='\033[0;31m'
BLU='\033[0;34m'
MAG='\033[0;35m'
RST='\033[0m'
BOLD='\033[1m'

echo -e "${CYN}=============================================================${RST}"
echo -e "${GRN}${BOLD}     HERMES AGENT - PROOT-DISTRO UBUNTU INSTALLER${RST}"
echo -e "${CYN}=============================================================${RST}"
echo -e "${BLU}🚀 Running Hermes Agent inside Ubuntu for maximum compatibility${RST}"
echo ""

# ============================================================
# STEP 1: Install proot-distro in Termux
# ============================================================
echo -e "${GRN}${BOLD}📦 STEP 1/5: Installing proot-distro...${RST}"
echo -e "${CYN}─────────────────────────────────────────────────────────────${RST}"

# Update Termux packages
pkg update -y -o Dpkg::Options::="--force-confnew" 2>/dev/null || pkg update -y

# Install proot-distro
if ! command -v proot-distro &> /dev/null; then
    echo -e "${CYN}📥 Installing proot-distro...${RST}"
    pkg install proot-distro -y
    echo -e "${GRN}✅ proot-distro installed${RST}"
else
    echo -e "${GRN}✅ proot-distro already installed${RST}"
fi

# ============================================================
# STEP 2: Install Ubuntu container
# ============================================================
echo ""
echo -e "${GRN}${BOLD}📦 STEP 2/5: Installing Ubuntu container...${RST}"
echo -e "${CYN}─────────────────────────────────────────────────────────────${RST}"

# Check if Ubuntu is already installed
if proot-distro list | grep -q "ubuntu"; then
    echo -e "${YEL}⚠️  Ubuntu container already exists${RST}"
    read -p "Reinstall Ubuntu? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${CYN}🗑️  Removing existing Ubuntu...${RST}"
        proot-distro remove ubuntu
        echo -e "${CYN}📥 Installing Ubuntu...${RST}"
        proot-distro install ubuntu
        echo -e "${GRN}✅ Ubuntu reinstalled${RST}"
    else
        echo -e "${GRN}✅ Using existing Ubuntu container${RST}"
    fi
else
    echo -e "${CYN}📥 Installing Ubuntu (this may take a few minutes)...${RST}"
    proot-distro install ubuntu
    echo -e "${GRN}✅ Ubuntu installed successfully${RST}"
fi

# ============================================================
# STEP 3: Create installation script inside Ubuntu
# ============================================================
echo ""
echo -e "${GRN}${BOLD}📦 STEP 3/5: Preparing Ubuntu installation script...${RST}"
echo -e "${CYN}─────────────────────────────────────────────────────────────${RST}"

# Create a script that will run INSIDE Ubuntu
cat > /tmp/hermes_ubuntu_install.sh << 'UBUNTU_SCRIPT'
#!/bin/bash

# This script runs INSIDE the Ubuntu proot-distro container
# It installs Hermes Agent

set -e

GRN='\033[0;32m'
CYN='\033[0;36m'
YEL='\033[0;33m'
BLU='\033[0;34m'
RST='\033[0m'
BOLD='\033[1m'

echo -e "${CYN}=============================================================${RST}"
echo -e "${GRN}${BOLD}     HERMES AGENT - UBUNTU (PROOT-DISTRO) INSTALLATION${RST}"
echo -e "${CYN}=============================================================${RST}"

# Update Ubuntu packages
echo -e "${GRN}📦 Updating Ubuntu packages...${RST}"
export DEBIAN_FRONTEND=noninteractive
apt update -qq && apt upgrade -y -qq

# Install dependencies
echo -e "${GRN}📦 Installing dependencies...${RST}"
apt install -y -qq \
    curl \
    git \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    pkg-config \
    libssl-dev \
    libffi-dev \
    clang \
    rustc \
    cargo \
    nodejs \
    npm \
    ripgrep \
    ffmpeg \
    wget \
    ca-certificates

# Install uv (fast Python package manager)
echo -e "${GRN}🚀 Installing uv package manager...${RST}"
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.cargo/env

# Clone Hermes Agent
echo -e "${GRN}📥 Cloning Hermes Agent...${RST}"
cd /root
rm -rf hermes-agent 2>/dev/null
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# Setup Python virtual environment
echo -e "${GRN}🐍 Setting up Python virtual environment...${RST}"
python3 -m venv venv
source venv/bin/activate

# Install Hermes Agent
echo -e "${GRN}🔧 Installing Hermes Agent...${RST}"
pip install --upgrade pip setuptools wheel
uv pip install -e '.[all]'

# Create symlink
ln -sf "$PWD/venv/bin/hermes" /usr/local/bin/hermes

echo -e "${GRN}=============================================================${RST}"
echo -e "${GRN}✅ Hermes Agent installed successfully in Ubuntu!${RST}"
echo -e "${GRN}=============================================================${RST}"
echo ""

# Create config directory
mkdir -p /root/.hermes

# Create .env template
if [ ! -f /root/.hermes/.env ]; then
    cat > /root/.hermes/.env << 'ENV_EOF'
# Hermes Agent Configuration
# Add your API keys here

# OpenAI
# OPENAI_API_KEY=sk-...

# Anthropic Claude
# ANTHROPIC_API_KEY=...

# Google Gemini
# GOOGLE_API_KEY=...

# DeepSeek
# DEEPSEEK_API_KEY=...

# Local Ollama (if running locally)
# OLLAMA_HOST=http://localhost:11434
ENV_EOF
    echo -e "${GRN}📝 Created ~/.hermes/.env template${RST}"
fi

echo -e "${CYN}🔥 To start Hermes: hermes${RST}"
echo -e "${CYN}🔧 To configure: hermes setup${RST}"
echo -e "${CYN}📖 Type 'hermes --help' for more options${RST}"
UBUNTU_SCRIPT

chmod +x /tmp/hermes_ubuntu_install.sh

# ============================================================
# STEP 4: Run installation script INSIDE Ubuntu
# ============================================================
echo ""
echo -e "${GRN}${BOLD}📦 STEP 4/5: Installing Hermes Agent inside Ubuntu...${RST}"
echo -e "${CYN}─────────────────────────────────────────────────────────────${RST}"
echo -e "${YEL}⚠️  This will take several minutes. Please wait...${RST}"
echo ""

# Copy the script into Ubuntu and run it
proot-distro login ubuntu -- bash -c "cat > /tmp/install_hermes.sh" < /tmp/hermes_ubuntu_install.sh
proot-distro login ubuntu -- bash /tmp/install_hermes.sh

# ============================================================
# STEP 5: Create convenient shortcuts
# ============================================================
echo ""
echo -e "${GRN}${BOLD}📦 STEP 5/5: Creating shortcuts...${RST}"
echo -e "${CYN}─────────────────────────────────────────────────────────────${RST}"

# Create a shortcut command in Termux to run Hermes inside Ubuntu
cat > $PREFIX/bin/hermes-ubuntu << 'SHORTCUT'
#!/data/data/com.termux/files/usr/bin/bash
# Shortcut to run Hermes Agent inside Ubuntu
proot-distro login ubuntu -- bash -c "source /root/hermes-agent/venv/bin/activate && hermes $*"
SHORTCUT

chmod +x $PREFIX/bin/hermes-ubuntu

# Also create aliases for common commands
cat >> ~/.bashrc << 'ALIASES' 2>/dev/null || true

# Hermes Agent Proot-Distro Aliases
alias hermes='hermes-ubuntu'
alias hermes-setup='proot-distro login ubuntu -- bash -c "source /root/hermes-agent/venv/bin/activate && hermes setup"'
alias hermes-config='proot-distro login ubuntu -- bash -c "source /root/hermes-agent/venv/bin/activate && hermes config"'
alias hermes-update='cd /tmp && curl -fsSL https://raw.githubusercontent.com/AbuZar-Ansarii/Hermes-Agent-On-Android/main/hermes_proot_install.sh | bash'
ALIASES

# Source bashrc to make aliases available
source ~/.bashrc 2>/dev/null || true

# ============================================================
# INSTALLATION COMPLETE!
# ============================================================
echo ""
echo -e "${GRN}${BOLD}=============================================================${RST}"
echo -e "${GRN}${BOLD}              ✅ INSTALLATION COMPLETE!${RST}"
echo -e "${GRN}${BOLD}=============================================================${RST}"
echo ""
echo -e "${CYN}${BOLD}🎉 Hermes Agent is now running inside Ubuntu on your Android!${RST}"
echo ""
echo -e "${GRN}${BOLD}📋 Quick Commands:${RST}"
echo -e "   ${CYN}hermes${RST}              - Start Hermes Agent"
echo -e "   ${CYN}hermes-ubuntu${RST}       - Direct Ubuntu Hermes command"
echo -e "   ${CYN}hermes setup${RST}        - Configure API keys & settings"
echo -e "   ${CYN}hermes config${RST}       - View/edit configuration"
echo -e "   ${CYN}hermes --help${RST}       - Show all commands"
echo ""
echo -e "${GRN}${BOLD}🐧 Ubuntu Management:${RST}"
echo -e "   ${CYN}proot-distro login ubuntu${RST}  - Enter Ubuntu shell"
echo -e "   ${CYN}proot-distro remove ubuntu${RST} - Remove Ubuntu container"
echo ""
echo -e "${YEL}${BOLD}📝 Next Steps:${RST}"
echo -e "   1. Run ${CYN}hermes setup${RST} to configure API keys"
echo -e "   2. Add your OpenAI/Anthropic/etc keys to ${CYN}/root/.hermes/.env${RST}"
echo -e "   3. Start chatting with ${CYN}hermes${RST}"
echo ""
echo -e "${BLU}💡 Need help? Visit:${RST} https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android"
echo ""
echo -e "${CYN}🔥 Run 'hermes' to start using Hermes Agent now!${RST}"
echo ""