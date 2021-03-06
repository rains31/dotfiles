SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "${SCRIPT}")

# sudo add-apt-repository ppa:pkg-vim/vim-daily -y
sudo apt-get update
# sudo apt-get install --reinstall vim
sudo apt-get install -y git cmake build-essential keychain autojump python-dev python3-dev

# install zsh
sudo apt-get install zsh
if [ ! -e ~/.oh-my-zsh ]; then
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    chsh -s `which zsh`
fi
# ## install powerlevel9k
# git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# 
# ## install awesome-terminal-fonts
# git clone https://github.com/gabrielelana/awesome-terminal-fonts.git /tmp/awesome-terminal-fonts
# bash /tmp/awesome-terminal-fonts/install.sh

## install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

# install zshrc
ln -sf ${BASEDIR}/.zshrc ~/.zshrc

# install vimrc
git clone git@github.com:dragonkid/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
## install Vundle & plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
## install YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --clang-completer --gocode-completer --tern-completer
## add colors
COLORS_DIR=~/.vim/colors/
mkdir -p ${COLORS_DIR} && cp ${BASEDIR}/colors/* ${COLORS_DIR}

# install tmuxrc
git clone git@github.com:dragonkid/tmux-config.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
## build tmux-mem-cpu-load
cd ~/.tmux && git submodule init && git submodule update
cd ~/.tmux/vendor/tmux-mem-cpu-load && cmake . && make && sudo make install

# install .gitconfig
ln -sf ${BASEDIR}/.gitconfig ~/.gitconfig
