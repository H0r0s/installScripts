#!/bin/bash

DIR=$(dirname "$(realpath $0)")'/configs'
# echo $DIR

### zsh------------------------------------------
sudo apt install zsh fonts-powerline curl -y
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-searc

# f for force to override existing
ln -sf $DIR/zshrc ~/.zshrc
### ---------------------------------------------

### vim------------------------------------------
sudo apt install -y vim
if [ ! -f "~/.vim/bundle/Vundle.vim" ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

ln -sf $DIR/vimrc ~/.vimrc
ln -sf $DIR/editorconfig ~/.editorconfig

vim -c 'PluginInstall' -c 'qa!'
### ---------------------------------------------

### tmux-----------------------------------------
ln -sf $DIR/tmux.conf ~/.tmux.conf
### ---------------------------------------------

### guake----------------------------------------
if [[ $(lsb_release -rs) == "18.04" ]]; then
  echo | sudo add-apt-repository ppa:linuxuprising/guake
  sudo apt-get update
fi
sudo apt install -y guake
sudo apt upgrade -y

sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/
guake --restore-preferences $DIR/guakePrefs
### ---------------------------------------------

echo -e "###########################################################################
### be careful, you have to change your home path in ~/.zshrc at line 5 ###
###########################################################################"
