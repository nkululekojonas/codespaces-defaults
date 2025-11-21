#!/bin/bash
set -e

DOTFILES_URL="https://raw.githubusercontent.com/nkululekojonas/dotfiles/main"

echo "Downloading dotfiles..."
curl -fsSL "$DOTFILES_URL/shell/functions.sh" -o "$HOME/.functionsrc"
curl -fsSL "$DOTFILES_URL/shell/aliases.sh" -o "$HOME/.aliasrc"

# Use .bash_aliases - automatically sourced by default .bashrc
cat > "$HOME/.bash_profile" << 'EOF'
[ -f "$HOME/.functionsrc" ] && source "$HOME/.functionsrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
EOF

echo "Setup complete! Files will load on next shell."
