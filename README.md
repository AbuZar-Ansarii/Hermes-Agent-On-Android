<div align="center">
<img width="1145" height="196" alt="hermesbanner" src="https://github.com/user-attachments/assets/68e4a2a7-74d2-4089-9e5f-6f0a46fe54f5" />


# *☤ Hermes Agent for Android (Termux)*

### *Run a Self-Evolving AI Assistant on Your Phone*

[![License: MIT](https://img.shields.io/badge/License-MIT-9146ff.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Termux](https://img.shields.io/badge/Termux-Android-ff6b6b.svg?style=for-the-badge)](https://termux.com/)
[![Version](https://img.shields.io/badge/version-v0.10.0-4ecdc4.svg?style=for-the-badge)](https://github.com/NousResearch/hermes-agent)
[![Stars](https://img.shields.io/github/stars/AbuZar-Ansarii/Hermes-Agent-On-Android?style=for-the-badge&color=ffd93d)](https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android)

**Transform your Android device into a powerful, learning AI assistant**
</div>

## ✨ What is Hermes Agent?

> **Hermes Agent** is an open-source, self-evolving AI framework developed by [Nous Research](https://github.com/NousResearch/hermes-agent). It's like having **Jarvis in your pocket** - an AI that learns, adapts, and grows smarter with every interaction.

<div align="center">

| 🧠 Self-Learning | 🔄 Cross-Platform | 💾 Persistent Memory | 🛠️ 70+ Tools |
|:----------------:|:------------------:|:-------------------:|:-------------:|
| Gets smarter over time | Works on 16+ apps | Remembers your preferences | Execute complex tasks |

</div>

---

## ⏱️ Installation takes ~5-10 minutes - Grab a coffee! ☕
</div>

## Installation Preview:
```mermaid
graph LR
    A[📱 Open Termux] --> B[📋 Copy Command]
    B --> C[⚡ Paste & Run]
    C --> D[🔄 Auto-Install]
    D --> E[✅ Ready to Use!]
```

# 🚀 **One-Line Installation**

### **Copy and paste this command in Termux:**
## *New Command*
#### Error Free & Updated (Recommended)

```
curl -fsSL https://raw.githubusercontent.com/AbuZar-Ansarii/All-Agents/main/hermes_install.sh | bash
```
**This may take some time so please wait for it to finish**

## Hermes agent start (if you close the terminal)
```
proot-distro login Ubuntu
hermes
```

## 🛠️ Hermes Agent Command Reference

| Command / Category | Syntax / Example | Description |
| :--- | :--- | :--- |
| **Start / Run** | `hermes` | Launch the Hermes Agent interactive interface. |
| **Setup & Configuration** | `hermes setup` | Run the initial interactive setup wizard to configure API keys, models, and dependencies. |
| **Gateway / Service** | `hermes gateway` | Start the Hermes Gateway service to listen for incoming connections, webhooks, or API requests. |
| **Direct Prompt** | `hermes "Analyze logs in ./src"` | Run Hermes directly with a specific instruction without entering interactive mode. |
| **File / Context Path** | `hermes -f ./app.js "Refactor this"` | Pass explicit file contexts or attachments into the session. |
| **Model Selection** | `hermes --model <model_name>` | Specify a custom or non-default model for the session. |
| **Interactive Commands** | `/help` | Display the list of available in-session commands and options. |
| **Clear Session** | `/clear` or `/reset` | Clear current context history and start fresh within the active session. |
| **Execute Shell** | `! <command>` *(e.g., `! ls -la`)* | Run a system shell command directly inside the Hermes terminal interface. |
| **Save Output** | `hermes "..." -o output.md` | Execute a task and save the agent's output directly to a file. |
| **Exit** | `/exit` or `Ctrl + C` | Safely terminate the active Hermes session. |



## Old

```bash
curl -fsSL https://raw.githubusercontent.com/AbuZar-Ansarii/Hermes-Agent-On-Android/main/nous_agent.sh | bash
```

## 🛠️ Manual Installation
Prefer to do it yourself? Here's the step-by-step:
```
pkg install git
```
```
# 1. Clone this repository
git clone https://github.com/AbuZar-Ansarii/Hermes-Agent-On-Android.git
cd Hermes-Agent-On-Android

# 2. Make the script executable
chmod +x agent_install.sh

# 3. Run the installer
./agent_install.sh
```

## 🤖 Start Agent
Run these commands one by one after installling
```
cd
proot-distro login ubuntu
```
```
cd hermes-agent
source venv/bin/activate
```
Run for setting it up
```
hermes setup
```
Run for using it
```
hermes
```
## Start gateway
```
hermes gateway
```

## ⚙️ System Requirements

| Requirement | Minimum | Recommended |
|:------------|:-------:|-------------:|
| **Android Version** | 11  |  13,14 or 15 |
| **Storage Space** | 3GB | 5GB+ |
| **RAM** | 2GB | 4GB+ |
| **Internet** | Required | Fast connection |
| **Termux** | Latest | Latest from F-Droid |


## 🌍 Why Run Hermes on Android?

| Benefit |  Description |
|:------------|:-------------:|
| **📱 Portable AI** | Your assistant goes everywhere  |
| **🔒 Privacy** | Runs locally on your device |
| **💰 Cost-effective** | No server hosting fees |
| **⚡ Low latency** | Direct execution |
| **🔄 Always available** | Works offline (with local models) |



## 🎛️ AI Model Freedom
Compatible with 200+ AI models including:

• OpenAI (GPT-4, GPT-3.5)

• Anthropic (Claude)

• Google (Gemini)

• DeepSeek

• Alibaba (Qwen)

• Zhipu (GLM)

• Local models via Ollama

## 🦙 Running Local Models with [Ollama](https://ollama.com)

### 📋 Installation

#### Install Ollama on Termux:
```
pkg install ollama
ollama serve
```
#### Pull & Run Models
```
ollama run gemma4:31b-cloud
```

## 🙏 Acknowledgments
• Nous Research - For creating the amazing Hermes Agent

• Termux Team - For making Android development possible

• Open Source Community - For the countless tools and libraries

• You - For using and supporting this project! ❤️


<div align="center">
    
## **⭐ If this helped you, give it a star! ⭐**
</div>

