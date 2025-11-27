#!/bin/bash
#
# Codespaces/install.sh: Downloads dotfiles and sets up Bash environment
DOTFILES="${HOME}/.dotfiles"
REPO_URL="https://www.github.com/nkululekojonas/dotfiles"

# --- 1. Clone Dotfiles Repository ---
if [[ -d "$DOTFILES" ]]; then
    echo "[INFO] Dotfiles directory already exists. Skipping clone."
else
    echo "[INFO] Cloning dotfiles to $DOTFILES..."
    git clone "$REPO_URL" "$DOTFILES" || { echo "[ERROR] Failed to clone repo."; exit 1; }
fi

# --- 2. Define XDG Variables and Directories ---
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
mkdir -p "${XDG_CONFIG_HOME}/bash"
mkdir -p "${XDG_CONFIG_HOME}/shell"

echo "[INFO] XDG configuration directories created."

# --- 3. Symlink Aliases, Functions, and Bash Config to XDG ---

# Helper function for symlinking
create_symlink() {
    local source="$1"
    local target="$2"
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "   [WARN] Backing up existing $target to ${target}.bak"
        mv -f "$target" "${target}.bak"
    fi
    echo "   [LINK] Creating symlink: $target -> $source"
    ln -sf "$source" "$target"
}

# Symlink Bash configuration (main .bashrc)
create_symlink "${DOTFILES}/bash/.bashrc" "${XDG_CONFIG_HOME}/bash/.bashrc"

# Symlink aliases and functions (using XDG structure)
create_symlink "${DOTFILES}/shell/.aliases" "${XDG_CONFIG_HOME}/shell/.aliases"
create_symlink "${DOTFILES}/shell/.functions" "${XDG_CONFIG_HOME}/shell/.functions"

# --- 4. Create Bootstrap .bashrc in Home Directory ---
BASHRC_STUB="${HOME}/.bashrc"
XDG_BASHRC="${XDG_CONFIG_HOME}/bash/.bashrc"

# Create a small stub in the traditional location (~/.bashrc)
# This stub simply sources the real XDG-compliant file.
echo "[INFO] Creating/updating bootstrap .bashrc in HOME directory."

# Use single quotes to prevent variable expansion now, ensuring the shell sources the file later
cat > "$BASHRC_STUB" <<- 'EOF'
#
# This file is a bootstrap stub managed by your dotfiles setup.
# It sources the main XDG-compliant configuration file.
#

# Check for and source the main XDG bash configuration
if [ -f "${HOME}/.config/bash/.bashrc" ]; then
    # Source the XDG-compliant .bashrc
    . "${HOME}/.config/bash/.bashrc"
fi
EOF

# Ensure the main XDG .bashrc loads your aliases/functions files:
# Your ~/.dotfiles/bash/.bashrc must contain:
# if [ -f "${XDG_CONFIG_HOME}/shell/.aliases" ]; then . "${XDG_CONFIG_HOME}/shell/.aliases"; fi
# if [ -f "${XDG_CONFIG_HOME}/shell/.functions" ]; then . "${XDG_CONFIG_HOME}/shell/.functions"; fi

echo "[SUCCESS] Bash environment setup complete!"
