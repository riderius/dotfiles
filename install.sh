PWD=$(pwd)
HOME="$HOME"

# install dependencies
if VERB="$( which pacman )" 2> /dev/null; then
    echo "Arch-based system"
    sudo pacman -Syu --needed base-devel zsh zsh-syntax-highlighting fish emacs openssh clang texlab python
    mkdir -p /tmp/yay
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -s -r -i
    yay -S cod-git
    pip install python-lsp-server
else
    echo "Unknown package manager, you need install: zsh(zsh-syntax-highlighting(https://github.com/zsh-users/zsh-syntax-highlighting)), emacs, openssh, cod, clangd, texlab, python-lsp-server"
fi

# zsh configuration
ZSH="$HOME/.oh-my-zsh/"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting
rm $HOME/.zshrc
ln -s $PWD/.zshrc $HOME/.zshrc
ln -s $PWD/.p10k.zsh $HOME/.p10k.zsh

# vim-like progs configuration
ln -s $PWD/.vimrc $HOME/.vimrc
mkdir -p $HOME/.config/nvim
ln -s $PWD/.config/nvim/init.vim $HOME/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# git configuration
ln -s $PWD/.gitconfig $HOME/.gitconfig
ln -s $PWD/.config/gitfiles $HOME/.config/gitfiles

# emacs configuration
mkdir $HOME/.emacs.d
ln -s $PWD/.emacs.d/init.el $HOME/.emacs.d/init.el
ln -s $PWD/.emacs.d/lisp $HOME/.emacs.d/lisp

# ssh configuration
ln -s $PWD/.ssh $HOME/.ssh

# .local/bin configuration
ln -s $PWD/.local/bin $HOME/.local/bin

# i3 configuration
ln -s $PWD/.config/i3 $HOME/.config/i3
ln -s $PWD/.config/i3status $HOME/.config/i3status

# fish configuration
ln -s $PWD/.config/fish $HOME/.config/fish
