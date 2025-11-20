#!/bin/bash

# Source file from personal dotfiles repo
DOTFILES_URL="https://raw.githubusercontent.com/nkululekojonas/dotfiles/main"

INSTALL_DIR="$HOME"

# Download Core Files
echo "Downloading aliases and functions..."
curl -fsSL "$DOTFILES_URL/shell/aliases.sh" -o "$INSTALL_DIR/.aliases"
curl -fsSL "$DOTFILES_URL/shell/functions.sh" -o "$INSTALL_DIR/.functions"

if [ -f "$INSTALL_DIR/.zshrc" ]; then
    echo "Sourcing aliases in .zshrc"
    echo "" >> "$INSTALL_DIR/.zshrc"
    echo "# Load custom Codespaces aliases and functions" >> "$INSTALL_DIR/.zshrc"
    echo "source \$HOME/.aliases" >> "$INSTALL_DIR/.zshrc"
fi

if [ -f "$INSTALL_DIR/.bashrc" ]; then
    echo "Sourcing aliases in .bashrc"
    echo "" >> "$INSTALL_DIR/.bashrc"
    echo "# Load custom Codespaces aliases and functions" >> "$INSTALL_DIR/.bashrc"
    echo "source \$HOME/.aliases" >> "$INSTALL_DIR/.bashrc"
fi

echo "Codespace dotfiles setup complete!"
