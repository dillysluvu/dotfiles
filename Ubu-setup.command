//preset 
sudo apt install git
sudo apt install npm

//zsh
sudo apt install zsh
curl sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

//support
sudo apt install fzf
sudo apt install zoxide
sudo apt-get install ripgrep
sudo apt install fd-find
sudo apt-get install neofetch

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

//kitty
sudo apt install kitty -y
sudo update-alternatives --config x-terminal-emulator
  
//tmux 
sudo apt install tmux 
sudo app install libevent-dev ncurses-dev build-essential bison pkg-config 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

//NeoVim
sudo apt install neovim

//LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim 
rm -rf ~/.config/nvim/.git
