#!/bin/bash

set -e
set -o pipefail

# Function to update and upgrade the system
update_system() {
    echo "Updating the system..."
    sudo pacman -Syu --noconfirm
}

# Function to install necessary packages
install_packages() {
    local packages=(
        git npm rust curl make bison gcc glibc zsh fzf ripgrep fd bat wezterm tmux
        libevent ncurses base-devel pkgconf neovim unrar lazygit yazi
    )
    echo "Installing packages..."
    sudo pacman -S --noconfirm "${packages[@]}"
}

# Function to install Zsh and Oh My Zsh
install_zsh() {
    if ! command -v zsh &> /dev/null; then
        echo "Installing Zsh..."
        sudo pacman -S --noconfirm zsh
    fi
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # ... (rest of the function remains the same)
}

# Function to install support tools
install_support_tools() {
    echo "Installing support tools..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    cargo install skim
    cargo install tlrc
}

# Function to install Tmux and dependencies
install_tmux() {
    echo "Installing Tmux..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Function to install Starship prompt
install_starship() {
    echo "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh
}

# Function to install GVM and NVM
install_version_managers() {
    echo "Installing version managers..."
    zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

# Function to configure user settings
configure_user() {
    echo "Configuring user settings..."
    repo_dir=$(dirname $(realpath $0))
    read -p "Do you want my v1 config or v2? (1/2): " config_version
    case "$config_version" in
        1)
            # ... (rest of the function remains the same)
            ;;
        2)
            # ... (rest of the function remains the same)
            ;;
        *)
            echo "Invalid selection. Exiting."
            exit 1
            ;;
    esac
}

# Function to handle ASUS laptop specific setup
setup_asus_laptop() {
    read -p "Do you use an ASUS laptop? (yes/no): " response
    if [[ "$response" == "yes" ]]; then
        # ... (rest of the function remains the same)
    fi
}

# Function to install Flatpak and add Flathub repository
setup_flatpak() {
    read -p "Do you want to install some Flatpak apps? (yes/no): " install_flatpak
    if [[ "$install_flatpak" == "yes" ]]; then
        # ... (rest of the function remains the same)
    else
        echo "Skipping Flatpak app installations."
    fi
}

# Main script execution
echo "Starting system setup..."
update_system
install_packages
install_zsh
install_support_tools
install_tmux
install_starship
install_version_managers
configure_user
setup_asus_laptop
setup_flatpak

# Source the new .zshrc if it exists
[ -f ~/.zshrc ] && source ~/.zshrc
echo "System setup complete!"
