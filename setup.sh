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
sudo dnf install libc6-dev -y

# Install Zsh
sudo dnf install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install support tools
sudo dnf install fzf -y
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sudo dnf install ripgrep -y
sudo dnf install fd-find -y
sudo dnf install neofetch -y
sudo dnf install bat -y
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

sudo dnf install wezterm
sudo update-alternatives --config x-terminal-emulator

# Install Tmux and dependencies
sudo dnf install tmux -y
sudo dnf install libevent-dev -y
sudo dnf install ncurses-dev -y
sudo dnf install build-essential -y
sudo dnf install pkg-config -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install GVM (Go Version Manager) and NVM (Node Version Manager )
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install NeoVim
sudo dnf install neovim -y

#  Config 
mv ~/Projects/dotfiles/nvim ~/.config/
mv ~/Projects/dotfiles/wezterm ~/.config/
mv ~/Projects/dotfiles/tmux ~/.config/
mv ~/Projects/dotfiles/starship.toml ~/.config/
mv ~/Projects/dotfiles/.zshrc $HOME

# Source the new .zshrc
source ~/.zshrc
