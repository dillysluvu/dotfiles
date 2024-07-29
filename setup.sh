#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Return the exit status of the last command in the pipe that failed

# Function to update and upgrade the system
update_system() {
    sudo dnf update -y
    sudo dnf upgrade -y
}

# Function to install necessary packages
install_packages() {
    local packages=(
        git npm rustc cargo curl make bison gcc glibc-devel zsh fzf ripgrep fd-find 
        fastfetch btop cava bat wezterm tmux libevent-devel ncurses-devel @development-tools 
        pkgconf-pkg-config neovim unrar 
    )
    sudo dnf install -y "${packages[@]}"
}

# Function to install Zsh and Oh My Zsh
install_zsh() {
    sudo dnf install -y zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# Function to install support tools
install_support_tools() {
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
}

# Function to install LazyGit
install_lazygit() {
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -f lazygit.tar.gz lazygit
}

# Function to install Tmux and dependencies
install_tmux() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Function to install Starship prompt
install_starship() {
    curl -sS https://starship.rs/install.sh | sh
}

# Function to install GVM and NVM
install_version_managers() {
    zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

# Function to configure user settings
configure_user() {
    read -p "Do you want my v1 config or v2? (1/2): " config_version
    case "$config_version" in
        1)
            mv ~/Projects/dotfiles/V1/nvim ~/.config/
            mv ~/Projects/dotfiles/wezterm ~/.config/
            mv ~/Projects/dotfiles/V1/tmux ~/.config/
            mv ~/Projects/dotfiles/starship ~/.config/
            mv ~/Projects/dotfiles/.zshrc $HOME
            ;;
        2)
            mv ~/Projects/dotfiles/V2/.vim $HOME
            mv ~/Projects/dotfiles/V2/.vimrc $HOME
            mv ~/Projects/dotfiles/wezterm ~/.config/
            mv ~/Projects/dotfiles/V2/tmux ~/.config/
            mv ~/Projects/dotfiles/starship ~/.config/
            mv ~/Projects/dotfiles/.zshrc $HOME
            ;;
        *)
            echo "Invalid selection. Exiting."
            exit 1
            ;;
    esac
}

# Function to handle Fedora Linux base and ASUS laptop specific setup
setup_asus_laptop() {
    read -p "Do you use Fedora Linux base and ASUS laptop? (yes/no): " response
    if [[ "$response" == "yes" ]]; then
        local packages=(
            cmake clang-devel libinput-devel libseat-devel libgbm-devel libxkbcommon-devel
            systemd-devel libdrm-devel expat-devel pcre2-devel libzstd-devel gtk3-devel
        )
        sudo dnf install -y "${packages[@]}"
        make
        sudo dnf copr enable lukenukem/asus-linux -y
        sudo dnf install asustl -y
    fi
}

# Main script execution
update_system
install_packages
install_zsh
install_support_tools
install_lazygit
install_tmux
install_starship
install_version_managers
configure_user
setup_asus_laptop

# Source the new .zshrc
source ~/.zshrc
