## 🚀 Codespaces Dotfiles Configuration

This repository contains the minimal dotfiles configuration specifically designed for use with **GitHub Codespaces**.

The goal of this project is to quickly provision a new Codespace environment with personal shell customizations (aliases, functions) without executing the full, complex installation routine (like macOS or Linux desktop defaults) used in my primary dotfiles repository.

### ⚙️ Installation

This repository is designed to be installed automatically using the GitHub Codespaces Dotfiles feature.

#### Prerequisites

1. Your personalized shell scripts (e.g., `aliases.sh`, `functions.sh`) must be publicly available in your main dotfiles repository.

#### Setup Steps

1. **Fork or Clone** this repository to your GitHub account.
2. Go to your GitHub **Settings**.
3. Navigate to **Codespaces** > **Dotfiles**.
4. Select this repository (`vscode-dotfiles` or whatever you named it) from the dropdown.
5. Ensure **"Automatically install dotfiles"** is checked.

---

### ✨ What It Does

The core logic is contained within the `install.sh` script:

1. **Downloads Specific Files:** It uses `curl` to fetch the necessary shell configuration files (`.aliases`, `.functions`) directly from the specified branch of my primary dotfiles repository.
2. **Configures Shell:** It safely appends the necessary `source` commands to the Codespace's shell configuration files (`.zshrc` and `.bashrc`).
3. **Persistence:** This ensures that all your custom functions and aliases are loaded **automatically** every time you open a new terminal session in any Codespace.

### 🔗 Linked Repository

This repository relies on the shell configuration files hosted here:

* [**nkululekojonas/dotfiles**](https://github.com/nkululekojonas/dotfiles) 

---

### 📝 Customization

If you need to update your aliases or functions, you only need to update the source files in your main `dotfiles` repository. Codespaces will pull the latest version of those files the next time a new Codespace is created or the `install.sh` script is manually re-run.

***

*Built for a seamless development experience in GitHub Codespaces.*
