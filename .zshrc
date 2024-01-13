# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/home/riderius/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# https://github.com/zsh-users/zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# pip zsh completion end

# From https://github.com/alexpaniman/dotfiles/blob/6dd2efb07741d79983fa7ec561a45b2a9f275f80/.zshrc#L75
run-cpp() {
    echo "------- COMPILER -------"
    echo "g++ ... -O2 $1 -o output.out"
    echo -ne "\n"

    compilation_beg_time="$(date +%s%N)"
    # g++ -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy \
    #     -Wdisabled-optimization -Wformat=2 -Winit-self -Wlogical-op \
    #     -Wmissing-include-dirs -Wnoexcept -Wold-style-cast -Woverloaded-virtual \
    #     -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstrict-null-sentinel \
    #     -Wstrict-overflow=5 -Wswitch-default -Wundef -Wconversion -Wuseless-cast \
    #     -Wzero-as-null-pointer-constant -O2 -march=native -O2 "$1" -o "output.out" || exit

    g++ -D NDEBUG -g -std=c++14 -Wall -Wextra -Weffc++ -Waggressive-loop-optimizations -Wc++0x-compat -Wc++11-compat -Wc++14-compat -Wcast-align -Wcast-qual -Wchar-subscripts -Wconditionally-supported -Wconversion -Wctor-dtor-privacy -Wempty-body -Wfloat-equal -Wformat-nonliteral -Wformat-security -Wformat-signedness -Wformat=2 -Winline -Wlarger-than=8192 -Wlogical-op -Wnon-virtual-dtor -Wopenmp-simd -Woverloaded-virtual -Wpacked -Wpointer-arith -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstack-usage=8192 -Wstrict-null-sentinel -Wstrict-overflow=2 -Wsuggest-attribute=noreturn -Wsuggest-final-methods -Wsuggest-final-types -Wsuggest-override -Wswitch-default -Wswitch-enum -Wsync-nand -Wundef -Wunreachable-code -Wunused -Wuseless-cast -Wvariadic-macros -Wno-literal-suffix -Wno-missing-field-initializers -Wno-narrowing -Wno-old-style-cast -Wno-varargs -fcheck-new -fsized-deallocation -fstack-check -fstack-protector -fstrict-overflow -flto-odr-type-merging -fno-omit-frame-pointer -fPIE -fsanitize=address -fsanitize=alignment -fsanitize=bool -fsanitize=bounds -fsanitize=enum -fsanitize=float-cast-overflow -fsanitize=float-divide-by-zero -fsanitize=integer-divide-by-zero -fsanitize=leak -fsanitize=nonnull-attribute -fsanitize=null -fsanitize=object-size -fsanitize=return -fsanitize=returns-nonnull-attribute -fsanitize=shift -fsanitize=signed-integer-overflow -fsanitize=undefined -fsanitize=unreachable -fsanitize=vla-bound -fsanitize=vptr -march=native -O2 -lm -pie "$1" -o "output.out" || return

    compilation_end_time="$(date +%s%N)"

    echo "-------- OUTPUT --------"
    run_beg_time="$(date +%s%N)"
    ./output.out
    run_end_time="$(date +%s%N)"
    echo -ne "\n"

    compilation_time="$((($compilation_end_time - $compilation_beg_time)/1000000))"
    run_time="$((($run_end_time - $run_beg_time)/1000000))"

    number_length="$((${#compilation_time} > ${#run_time} ? ${#compilation_time} : ${#run_time}))"

    echo "-------- STATUS --------"
    printf "Compilation time: %*sms\n" "$number_length" "$compilation_time"
    printf "Execution   time: %*sms\n" "$number_length" "$run_time"

    rm output.out
}

# swallow from https://github.com/alexpaniman/dotfiles/blob/6dd2efb07741d79983fa7ec561a45b2a9f275f80/.zshrc#L112
swallow() {
    # get terminal window id
    wid=$(xdo id)

    # hide terminal
    xdo hide "$wid"

    "$@" # run program

    # show terminal again
    xdo show "$wid"
}

# From https://superuser.com/questions/141044/sharing-the-same-ssh-agent-among-multiple-login-sessions
function sshagent_findsockets {
    find /tmp -uid $(id -u) -type s -name agent.\* 2>/dev/null
}

function sshagent_testsocket {
    if [ ! -x "$(which ssh-add)" ] ; then
        echo "ssh-add is not available; agent testing aborted"
        return 1
    fi

    if [ X"$1" != X ] ; then
        export SSH_AUTH_SOCK=$1
    fi

    if [ X"$SSH_AUTH_SOCK" = X ] ; then
        return 2
    fi

    if [ -S $SSH_AUTH_SOCK ] ; then
        ssh-add -l > /dev/null
        if [ $? = 2 ] ; then
            echo "Socket $SSH_AUTH_SOCK is dead!  Deleting!"
            rm -f $SSH_AUTH_SOCK
            return 4
        else
            #echo "Found ssh-agent $SSH_AUTH_SOCK"
            return 0
        fi
    else
        echo "$SSH_AUTH_SOCK is not a socket!"
        return 3
    fi
}

function sshagent_init {
    # ssh agent sockets can be attached to a ssh daemon process or an
    # ssh-agent process.

    AGENTFOUND=0

    # Attempt to find and use the ssh-agent in the current environment
    if sshagent_testsocket ; then AGENTFOUND=1 ; fi

    # If there is no agent in the environment, search /tmp for
    # possible agents to reuse before starting a fresh ssh-agent
    # process.
    if [ $AGENTFOUND = 0 ] ; then
        for agentsocket in $(sshagent_findsockets) ; do
            if [ $AGENTFOUND != 0 ] ; then break ; fi
            if sshagent_testsocket $agentsocket ; then AGENTFOUND=1 ; fi
        done
    fi

    # If at this point we still haven't located an agent, it's time to
    # start a new one
    if [ $AGENTFOUND = 0 ] ; then
        eval `ssh-agent -t 900` > /dev/null
    fi

    # Clean up
    unset AGENTFOUND
    unset agentsocket

    # Finally, show what keys are currently in the agent
    #ssh-add -l
}

# Aliases
alias emacs="emacs -nw"
alias C="LC_ALL=C"
alias makepkg="makepkg --config ~/.config/pacman/makepkg.conf"
alias sagent="sshagent_init"
alias cppman-set-cppreference="cppman -s cppreference.com"
alias cppman-set-cplusplus="cppman -s cplusplus.com"

# Vars
# export EDITOR="emacs -nw"
export EDITOR="nvim"
export GPG_TTY=$TTY
export LESSOPEN='| LESSQUIET=1 lesspipe.sh %s'

# export TODAY_CMD=${TODAY_CMD:-'nvim -c "above sp $TODAY_TODO" -c "tabe $TODAY_DIR" -c "tabr" "$TODAY_FILE"'}
export TODAY_DIR=${TODAY_DIR-${XDG_DATA_HOME:-${HOME}/.local/share}/today}
export TODAY_SUFFIX=${TODAY_SUFFIX-.md.gpg}
GPG_TTY=`tty`
export GPG_TTY

# cod -- https://github.com/dim-an/cod
source <(cod init $$ zsh)

# Enable ssh-agent
sagent
