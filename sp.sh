#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Return the exit status of the last command in the pipe that failed

# Function to update and upgrade the system
update_system() {
    sudo pacman -Syu --noconfirm
}

# Function to install necessary packages
install_packages() {
    local packages=(
        git npm rust curl make bison gcc glibc zsh fzf ripgrep fd bat wezterm tmux
        libevent ncurses base-devel pkgconf neovim unrar
    )
    sudo pacman -S --noconfirm "${packages[@]}"
}

# Function to install Zsh and Oh My Zsh
install_zsh() {
    if ! command -v zsh &> /dev/null; then
        sudo pacman -S --noconfirm zsh
    fi
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# Function to install support tools
install_support_tools() {
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    cargo install skim
    cargo install broot
}

# Function to install LazyGit
install_lazygit() {
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    TEMP_FILE=$(mktemp)
    curl -Lo "$TEMP_FILE" "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf "$TEMP_FILE" lazygit
    sudo install lazygit /usr/local/bin
    rm -f "$TEMP_FILE" lazygit
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

# Function to handle ASUS laptop specific setup
setup_asus_laptop() {
    read -p "Do you use an ASUS laptop? (yes/no): " response
    if [[ "$response" == "yes" ]]; then
        local packages=(
            cmake clang libinput libseat libgbm libxkbcommon systemd libdrm expat pcre2 zstd gtk3 base-devel git
        )
        sudo pacman -S --noconfirm "${packages[@]}"
        sudo pacman -S power-profiles-daemon
        if ! command -v yay &> /dev/null; then
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si
            cd ..
            rm -rf yay
        fi
        yay -S asusctl supergfxctl rog-control-center

        sudo systemctl enable --now power-profiles-daemon.service
        sudo systemctl enable --now supergfxd.service
        sudo systemctl enable --now asusd.service
    fi
}

# Function to install Flatpak and add Flathub repository
setup_flatpak() {
    read -p "Do you want to install some Flatpak apps? (yes/no): " install_flatpak
    if [[ "$install_flatpak" == "yes" ]]; then
        if ! command -v flatpak &> /dev/null; then
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
            "com.github.jakeman.ExtensionManager"
            "dev.vencord.Vesktop"
            "garden.jamie.Morphosis"
            "io.bassi.Amberol"
            "io.github.getnf.embellish"
            "com.github.wiiznokes.fan-control"
            "io.gitlab.adhami3310.Converter"
            "io.github.missioncenter.MissionCenter"
            "it.mijorus.gearlever"
            "org.freac.freac"
            "org.gnome.Extensions"
            "org.gnome.gitlab.somas.Apostrophe"
        )

        read -p "Would you like to install all Flatpak apps? (yes/no): " install_all

        if [[ "$install_all" == "yes" ]]; then
            for app in "${apps[@]}"; do
                flatpak install -y flathub "$app"
            done
            echo "All apps have been installed."
        else
            for app in "${apps[@]}"; do
                read -p "Do you want to install $app? (yes/no): " response
                if [[ "$response" == "yes" ]]; then
                    flatpak install -y flathub "$app"
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
install_zsh
install_support_tools
install_lazygit
install_tmux
install_starship
install_version_managers
configure_user
setup_asus_laptop
setup_flatpak

# Source the new .zshrc if it exists
[ -f ~/.zshrc ] && source ~/.zshrc

