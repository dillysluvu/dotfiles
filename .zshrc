# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Add local bin to PATH for custom binaries
export PATH="$HOME/.local/bin:$PATH"

# Set the theme for oh-my-zsh
ZSH_THEME="apple"

# Load plugins
plugins=(
  git                    
  you-should-use        
  zsh-syntax-highlighting
  zsh-autosuggestions   
  zsh-bat              
)

# Source oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

# User configuration

# Initialize tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Add custom paths
export PATH="$PATH:/opt/nvim:/home/mcv/depot_tools"
export PKG_CONFIG_PATH="/usr/lib/pkgconfig"
export HELIX_RUNTIME="$HOME/src/helix/runtime"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export GDK_BACKEND="wayland"

# Initialize version managers
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Initialize fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Initialize `thefuck`
eval "$(thefuck --alias fuck)"

# Aliases
alias hx='helix'  
alias ls='eza'   
alias sauto='f() { source ~/auto.sh && auto "$1"; }; f'
alias debug='g++ debug.cpp -o debug && ./debug'

# Initialize Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Add custom Zsh functions directory to fpath
fpath+=("${ZDOTDIR:-$HOME}/.zsh_functions")

# Set Vim as the default editor
export EDITOR="vim"

