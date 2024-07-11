
# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# replace apt package 

sudo nala install nala -y
sudo nala fetch

# Install necessary packages
sudo nala install git -y
sudo nala install npm -y
sudo nala install rustc cargo -y
sudo nala install curl -y
sudo nala install make -y
sudo nala install bison -y
sudo nala install gcc -y
sudo nala install libc6-dev -y

# Install Zsh
sudo nala install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install support tools
sudo nala install fzf -y
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
sudo nala install ripgrep -y
sudo nala install fd-find -y
sudo nala install neofetch -y
sudo nala install bat -y
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install Wezterm terminal emulator
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo nala update
sudo nala install wezterm
sudo update-alternatives --config x-terminal-emulator

# Install Tmux and dependencies
sudo nala install tmux -y
sudo nala install libevent-dev -y
sudo nala install ncurses-dev -y
sudo nala install build-essential -y
sudo nala install pkg-config -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Install GVM (Go Version Manager) and NVM (Node Version Manager )
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install NeoVim
sudo nala install neovim -y

#  Config 
mv ~/Projects/dotfiles/nvim ~/.config/
mv ~/Projects/dotfiles/wezterm ~/.config/
mv ~/Projects/dotfiles/tmux ~/.config/
mv ~/Projects/dotfiles/starship.toml ~/.config/
mv ~/Projects/dotfiles/.zshrc $HOME

# Source the new .zshrc
source ~/.zshrc
