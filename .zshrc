# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Set name of the theme to load
ZSH_THEME="apple"

# Plugins
plugins=(
  git
  you-should-use
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-bat
)

source $ZSH/oh-my-zsh.sh

# User configuration
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Add custom paths
export PATH="$PATH:/opt/nvim/:/home/mcv/depot_tools"
export PKG_CONFIG_PATH=/usr/lib/pkgconfig
export HELIX_RUNTIME=~/src/helix/runtime
export STARSHIP_CONFIG=/home/mcv/.config/starship/starship.toml

# Initialize Go version manager (GVM)
[[ -s "/home/mcv/.gvm/scripts/gvm" ]] && source "/home/mcv/.gvm/scripts/gvm"

# Initialize Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Initialize fzf key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Initialize thefuck
eval $(thefuck --alias fuck)

# Add aliases
alias dnf='dnf5'

# Initialize Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Source broot launcher
source /home/mcv/.config/broot/launcher/bash/br

# Add zsh functions path
fpath+=${ZDOTDIR:-~}/.zsh_functions

