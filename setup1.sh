#!/usr/bin/env bash

set -euxo pipefail

# Check if the required command exists
command_exists() {
    type "$1" &> /dev/null
}

# Function to update and upgrade the system
update_system() {
    if command_exists pacman; then
        sudo pacman -Syu --noconfirm
    else
        echo "Pacman not found. Please run this script on an Arch-based system."
        exit 1
    fi
}

# Function to install necessary packages
install_packages() {
    local packages=(
        git npm rust curl make bison gcc glibc zsh fzf ripgrep fd bat wezterm tmux
        libevent ncurses base-devel pkgconf neovim unrar lazygit yazi gnome-menus cmake python-nautilus
    )
    sudo pacman -S --noconfirm "${packages[@]}"
}

# Function to remove unwanted packages
remove_unwanted_packages() {
    sudo pacman -Rns --noconfirm gedit gnome-terminal || true
}

# Function to install Zsh and Oh My Zsh
install_zsh() {
    if ! command_exists zsh; then
        echo "Installing Zsh..."
        sudo pacman -S --noconfirm zsh
    else
        echo "Zsh is already installed."
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true
    else
        echo "Oh My Zsh is already installed."
    fi

    # Set up custom plugins directory
    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
    mkdir -p "$ZSH_CUSTOM"

    # Clone additional plugins
    echo "Cloning plugins..."
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/you-should-use" || true
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting" || true
    git clone https://github.com/fdellwing/zsh-bat.git "$ZSH_CUSTOM/zsh-bat" || true
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/zsh-autosuggestions" || true

    echo "Zsh and plugins installation complete!"
}

# Function to install support tools
install_support_tools() {
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh || true
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh || true
    cargo install skim broot tlrc || true
}

# Function to install Tmux and dependencies
install_tmux() {
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
    fi
}

# Function to install Starship prompt
install_starship() {
    if ! command_exists starship; then
        curl -sS https://starship.rs/install.sh | sh || true
    else
        echo "Starship is already installed."
    fi
}

# Function to install GVM and NVM
install_version_managers() {
    if ! command_exists gvm; then
        zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) || true
    fi

    if ! command_exists nvm; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash || true
    fi
}

# Function to configure user settings
configure_user() {
    local repo_dir
    repo_dir=$(dirname "$(realpath "$0")")
    read -p "Do you want my v1 config or v2? (1/2): " config_version
    case "$config_version" in
        1)
            mv "$repo_dir/V1/nvim" ~/.config/ || true
            mv "$repo_dir/wezterm" ~/.config/ || true
            mv "$repo_dir/V1/tmux" ~/.config/ || true
            mv "$repo_dir/starship" ~/.config/ || true
            mv "$repo_dir/.zshrc" "$HOME" || true
            ;;
        2)
            mv "$repo_dir/V2/.vim" "$HOME" || true
            mv "$repo_dir/V2/.vimrc" "$HOME" || true
            mv "$repo_dir/wezterm" ~/.config/ || true
            mv "$repo_dir/V2/tmux" ~/.config/ || true
            mv "$repo_dir/starship" ~/.config/ || true
            mv "$repo_dir/V1/nvim" ~/.config/ || true
            mv "$repo_dir/.zshrc" "$HOME" || true
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
        local packages=(
            cmake clang libinput libseat libgbm libxkbcommon systemd libdrm expat pcre2 zstd gtk3 base-devel git
        )
        sudo pacman -S --noconfirm "${packages[@]}"
        sudo pacman -S --noconfirm power-profiles-daemon || true
        if ! command_exists yay; then
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si || true
            cd ..
            rm -rf yay
        fi
        yay -S --noconfirm asusctl supergfxctl rog-control-center || true

        sudo systemctl enable --now power-profiles-daemon.service || true
        sudo systemctl enable --now supergfxd.service || true
        sudo systemctl enable --now asusd.service || true
    fi
}

# Function to install Flatpak and add Flathub repository
setup_flatpak() {
    read -p "Do you want to install some Flatpak apps? (yes/no): " install_flatpak
    if [[ "$install_flatpak" == "yes" ]]; then
        if ! command_exists flatpak; then
            sudo pacman -S --noconfirm flatpak
        fi
        sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

        local apps=(
            "app.drey.Warp"
            "com.github.KRTirtho.Spotube"
            "com.github.flxzt.rnote"
            "com.github.neithern.g4music"
            "com.github.tchx84.Flatseal"
            "com.github.wwmm.easyeffects"
            "com.mattjakeman.ExtensionManager"
            "dev.vencord.Vesktop"
            "garden.jamie.Morphosis"
            "io.github.getnf.embellish"
            "io.gitlab.adhami3310.Converter"
            "it.mijorus.gearlever"
            "org.freac.freac"
            "org.gnome.Extensions"
            "org.gnome.gitlab.somas.Apostrophe"
            "org.gnome.Cheese"
            "org.kde.kamoso"
            "org.mozilla.Thunderbird"
            "io.github.amit9838.mousam"
        )

        read -p "Would you like to install all Flatpak apps? (yes/no): " install_all

        if [[ "$install_all" == "yes" ]]; then
            for app in "${apps[@]}"; do
                flatpak install -y flathub "$app" || true
            done
            echo "All apps have been installed."
        else
            for app in "${apps[@]}"; do
                read -p "Do you want to install $app? (yes/no): " response
                if [[ "$response" == "yes" ]]; then
                    flatpak install -y flathub "$app" || true
                else
                    echo "Skipping $app"
                fi
            done
            echo "Selected apps have been installed."
        fi
    else
        echo "Skipping Flatpak app installations."
    fi
}

# Main script execution
update_system
install_packages
remove_unwanted_packages
install_zsh
install_support_tools
install_tmux
install_starship
install_version_managers
configure_user
setup_asus_laptop
setup_flatpak

echo "System setup complete!"
