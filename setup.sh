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
    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/you-should-use"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting"
    git clone https://github.com/fdellwing/zsh-bat.git "$ZSH_CUSTOM/zsh-bat"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"
}

# Function to install support tools
install_support_tools() {
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    cargo install broot 
    cargo install skim 
    cargo install tlrc
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
    repo_dir=$(dirname "$(realpath "$0")")
    read -p "Do you want my v1 config or v2? (1/2): " config_version
    case "$config_version" in
        1)
            mv "$repo_dir/V1/nvim" ~/.config/
            mv "$repo_dir/wezterm" ~/.config/
            mv "$repo_dir/V1/tmux" ~/.config/
            mv "$repo_dir/starship" ~/.config/
            mv "$repo_dir/.zshrc" "$HOME"
            ;;
        2)
            mv "$repo_dir/V2/.vim" "$HOME"
            mv "$repo_dir/V2/.vimrc" "$HOME"
            mv "$repo_dir/wezterm" ~/.config/
            mv "$repo_dir/V2/tmux" ~/.config/
            mv "$repo_dir/starship" ~/.config/
            mv "$repo_dir/V1/nvim" ~/.config/
            mv "$repo_dir/.zshrc" "$HOME"
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
        sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf update -y
        sudo dnf install -y power-profiles-daemon asusctl supergfxctl rog-control-center
        sudo systemctl enable power-profiles-daemon
        sudo systemctl start power-profiles-daemon
        sudo systemctl enable asusd
        sudo systemctl start asusd
        sudo systemctl enable supergfxd
        sudo systemctl start supergfxd
    fi
}

# Function to prompt the user to install Flatpak and add Flathub repository
setup_flatpak() {
    read -p "Do you want to install some Flatpak apps? (yes/no): " install_flatpak
    if [[ "$install_flatpak" == "yes" ]]; then
        sudo dnf install -y flatpak
        sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        
        # Add Flatpak application installation functionality
        install_flatpak_apps() {
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
        
            echo "Setup complete."
        }
        
        install_flatpak_apps
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

# Source the new .zshrc
source ~/.zshrc
