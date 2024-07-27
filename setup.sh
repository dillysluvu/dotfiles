#!/bin/bash

# Update and upgrade the system
sudo dnf update -y
sudo dnf upgrade -y

# Install necessary packages
sudo dnf install git -y
sudo dnf install npm -y
sudo dnf install rustc cargo -y
sudo dnf install curl -y
sudo dnf install make -y
sudo dnf install bison -y
sudo dnf install gcc -y
sudo dnf install glibc-devel -y  # libc6-dev equivalent

# Install Zsh
sudo dnf install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install support tools
sudo dnf install fzf -y
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sudo dnf install ripgrep -y
sudo dnf install fd-find -y
sudo dnf install fastfetch -y
sudo dnf install btop -y
sudo dnf install cava -y
sudo dnf install bat -y
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install Wezterm
sudo dnf install wezterm -y
sudo update-alternatives --config x-terminal-emulator

# Install Tmux and dependencies
sudo dnf install tmux -y
sudo dnf install libevent-devel -y
sudo dnf install ncurses-devel -y
sudo dnf install @development-tools -y  # build-essential equivalent
sudo dnf install pkgconf-pkg-config -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install GVM (Go Version Manager) and NVM (Node Version Manager)
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install NeoVim
sudo dnf install neovim -y

# Prompt for configuration version
read -p "Do you want my v1 config or v2? (1/2): " config_version
if [[ "$config_version" == "1" ]]; then
    mv ~/Projects/dotfiles/V1/nvim ~/.config/
    mv ~/Projects/dotfiles/wezterm ~/.config/
    mv ~/Projects/dotfiles/V1/tmux ~/.config/
    mv ~/Projects/dotfiles/starship ~/.config/
    mv ~/Projects/dotfiles/.zshrc $HOME
elif [[ "$config_version" == "2" ]]; then
    mv ~/Projects/dotfiles/V2/.vim $HOME
    mv ~/Projects/dotfiles/V2/.vimrc $HOME
    mv ~/Projects/dotfiles/wezterm ~/.config/
    mv ~/Projects/dotfiles/V2/tmux ~/.config/
    mv ~/Projects/dotfiles/starship ~/.config/
    mv ~/Projects/dotfiles/.zshrc $HOME
fi

# Prompt for Fedora Linux base and ASUS laptop
read -p "Do you use Fedora Linux base and ASUS laptop? (yes/no): " response
if [[ "$response" == "yes" ]]; then
    sudo dnf install cmake clang-devel libinput-devel libseat-devel libgbm-devel libxkbcommon-devel systemd-devel libdrm-devel expat-devel pcre2-devel libzstd-devel gtk3-devel -y
    make
    sudo dnf copr enable lukenukem/asus-linux -y
    sudo dnf install asustl -y
fi

# Source the new .zshrc
source ~/.zshrc
