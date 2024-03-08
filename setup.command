//preset 
sudo dnf install git -y
sudo dnf install npm
sudo dnf install rust cargo

sudo yum install curl
sudo yum install make
sudo yum install bison
sudo yum install gcc
sudo yum install glibc-devel

//zsh
sudo dnf install zsh
curl sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

//fish
sudo dnf install fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v6
fisher install jethrokuan/z
sudo dnf install eza
fisher install PatrickF1/fzf.fish
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish
git clone https://github.com/x-motemen/ghq .
make install



//support
sudo dnf install fzf
sudo dnf install zoxide
sudo dnf install ripgrep
sudo dnf install fd-find
sudo dnf install neofetch
sudo dnf install bat

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

//kitty
sudo dnf install kitty 
sudo update-alternatives --config x-terminal-emulator
  
//tmux 
sudo dnf install tmux 
sudo dnf install libevent-dev ncurses-dev build-essential bison pkg-config 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

//nothing 
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

//NeoVim
sudo dnf install neovim

//LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim 
rm -rf ~/.config/nvim/.git

//asustl 
sudo dnf install cmake clang-devel systemd-devel glib2-devel cairo-devel atkmm-devel pangomm-devel gdk-pixbuf2-devel gtk3-devel libappindicator-gtk3
make

//snap
sudo dnf install snap
sudo snap install gitkraken --classic

