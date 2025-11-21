#!/bin/bash
set -e  # Exit on any error

DOTFILES_URL="https://raw.githubusercontent.com/nkululekojonas/dotfiles/main"
INSTALL_DIR="$HOME"

# Download files with error checking
echo "Downloading dotfiles..."
if ! curl -fsSL "$DOTFILES_URL/shell/functions.sh" -o "$INSTALL_DIR/.functionsrc"; then
    echo "Error: Failed to download functions.sh"
    exit 1
fi

if ! curl -fsSL "$DOTFILES_URL/shell/aliases.sh" -o "$INSTALL_DIR/.aliasrc"; then
    echo "Error: Failed to download aliases.sh"
    exit 1
fi

# Function to safely append source commands
add_source_lines() {
    local rcfile=$1
    
    if [ ! -f "$rcfile" ]; then
        echo "Warning: $rcfile not found, skipping"
        return
    fi
    
    # Check if already added (prevent duplicates)
    if grep -q "source.*\.functionsrc" "$rcfile" 2>/dev/null; then
        echo "Already configured in $rcfile"
        return
    fi
    
    echo "Configuring $rcfile..."
    cat >> "$rcfile" << 'EOF'

# Load custom dotfiles
[ -f "$HOME/.functionsrc" ] && source "$HOME/.functionsrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
EOF
}

# Configure shell rc files
add_source_lines "$HOME/.zshrc"
add_source_lines "$HOME/.bashrc"

echo "Codespace dotfiles setup complete!"