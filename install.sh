PWD=$(pwd)
HOME="$HOME"

# install dependencies
git submodule update --init
if VERB="$( which pacman )" 2> /dev/null; then
    sudo pacman -Syu --needed base-devel zsh zsh-syntax-highlighting\
        zsh-autosuggestions fish fzf emacs vim neovim openssh clang texlab\
        python python-pip pkgfile alacritty
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -s -r -i
    yay -S cod-git
    cd ..
    rm yay -rf
    pip install python-lsp-server[all]
else
    echo "Unknown package manager, you need install: zsh(zsh-syntax-highlighting(https://github.com/zsh-users/zsh-syntax-highlighting), zsh-autosuggestions), pkgfile, fish, fzf, emacs, vim, neovim, openssh, cod, clangd, texlab, python-lsp-server, alacritty"
fi

# zsh configuration
ZSH="$HOME/.oh-my-zsh/"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting
rm $HOME/.zshrc
ln -s $PWD/.zshrc $HOME/.zshrc
ln -s $PWD/.p10k.zsh $HOME/.p10k.zsh
ln -s $PWD/.dir_colors $HOME/.dir_colors

# vim-like progs configuration
ln -s $PWD/.vimrc $HOME/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
ln -s $PWD/.local/bin/restart-nm $HOME/.local/bin/restart-nm
ln -s $PWD/.local/bin/windscribe-start $HOME/.local/bin/windscribe-start
ln -s $PWD/.local/bin/windscribe-stop $HOME/.local/bin/windscribe-stop
ln -s $PWD/.local/bin/ydstatus $HOME/.local/bin/ydstatus

# i3 configuration
ln -s $PWD/.config/i3 $HOME/.config/i3
ln -s $PWD/.config/i3status $HOME/.config/i3status

# fish configuration
ln -s $PWD/.config/fish/config.fish $HOME/.config/fish/config/fish
ln -s $PWD/.config/fish/functions $HOME/.config/fish/functions
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fish -c 'omf install https://github.com/PatrickF1/fzf.fish'

# Alacritty configuration
mkdir -p $HOME/.config/alacritty
ln -s $PWD/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
