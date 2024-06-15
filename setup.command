#!/bin/bash

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Install necessary packages
sudo apt install git -y
sudo apt install npm -y
sudo apt install rustc cargo -y
sudo apt install curl -y
sudo apt install make -y
sudo apt install bison -y
sudo apt install gcc -y
sudo apt install libc6-dev -y

# Install Zsh
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install support tools
sudo apt install fzf -y
sudo apt install zoxide -y
sudo apt install ripgrep -y
sudo apt install fd-find -y
sudo apt install neofetch -y
sudo apt install bat -y

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install Kitty terminal emulator
sudo apt install kitty -y
sudo update-alternatives --config x-terminal-emulator

# Install Tmux and dependencies
sudo apt install tmux -y
sudo apt install libevent-dev -y
sudo apt install ncurses-dev -y
sudo apt install build-essential -y
sudo apt install pkg-config -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config
touch ~/.config/starship.toml

# Install GVM (Go Version Manager)
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# Install NeoVim
sudo apt install neovim -y

# Set up LazyVim configuration
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Install additional packages for Asustl
sudo apt install cmake -y
sudo apt install clang -y
sudo apt install systemd -y
sudo apt install libglib2.0-dev -y
sudo apt install libcairo2-dev -y
sudo apt install libatkmm-1.6-dev -y
sudo apt install libpangomm-1.4-dev -y
sudo apt install libgdk-pixbuf2.0-dev -y
sudo apt install libgtk-3-dev -y
sudo apt install libappindicator3-dev -y
