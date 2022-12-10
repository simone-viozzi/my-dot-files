# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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


source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-interactive-cd
    git
    poetry
    zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
    zsh-autosuggestions     # https://github.com/zsh-users/zsh-autosuggestions
    zsh-completions         # https://github.com/zsh-users/zsh-completions
    colored-man-pages       # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
    docker                  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
    docker-compose          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
    forgit                  # https://github.com/wfxr/forgit/issues/212
    aliases                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases
    aws
    extract                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
    fzf                     # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
    fzf-tab                 # https://github.com/Aloxaf/fzf-tab
    git-auto-fetch          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch
    jsontools               # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jsontools
    rsync                   # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync
    systemd                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
    direnv                  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/direnv
    dotbare                 # https://github.com/kazhala/dotbare
    zsh-z                   # https://github.com/agkozak/zsh-z
)

fpath=(/home/simone/.zsh-completion $fpath /usr/share/zsh/vendor-completions)

autoload -U compinit && compinit
export FZF_BASE=/usr/bin/fzf

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

# add ruby to path
export PATH="/home/simone/.local/share/gem/ruby/3.0.0/bin:$PATH"


source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias ls='exa --icons -F'
alias la='exa -la --icons -F'
alias lg='exa -l -F --icons --git --sort=modified'
alias tree='exa -F --icons --tree'
alias tree-git='exa --icons --tree --git-ignore'
alias du='echo "WARNING use dust" && du'
alias xopen="gio open 2>/dev/null"
alias yolo="git add . && curl -s http://whatthecommit.com/index.txt | git commit -F - && git push"
alias conf='dotbare'
alias conf-yolo="curl -s http://whatthecommit.com/index.txt | conf commit -a -F - && conf push"
alias a="acs"
alias h2='function hdi(){ howdoi $* -ca | less --raw-control-chars --quit-if-one-screen --no-init; }; hdi'
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
alias rename="perl-rename"


# those functions are to provide a better interface to the json plugin
# allow for bot pipe and terminal input and give systax highlight 
# with bat
json(){
    local j
    if [ -t 0 ]; then
        # terminal
        j=$(cat $1)
    else
        # pipe
        j=$(< /dev/stdin)
    fi
    echo $j | pp_json | bat -l json
}
jsonl(){
    local j
    if [ -t 0 ]; then
        # terminal
        j=$(head -n2 $1)
    else
        # pipe
        j=$(head -n2 < /dev/stdin)
    fi
    echo $j | pp_ndjson | bat -l json
}

cheat() {
    curl -s cheat.sh/$1 | less
}

docker-cleanup () {
    docker container prune -f --filter "until=300h"
    docker image prune -f -a --filter "until=300h"
    docker volume prune -f --filter "label!=keep"
    docker network prune -f --filter "until=300h"
    docker builder prune -f --filter "until=300h"
}


LIGHT_COLOR='base16-equilibrium-gray-light.yml'
DARK_COLOR='base16-onedark.yml'

alias day="alacritty-colorscheme -V apply $LIGHT_COLOR"
alias night="alacritty-colorscheme -V apply $DARK_COLOR"
alias toggle="alacritty-colorscheme -V toggle $LIGHT_COLOR $DARK_COLOR"


export DIFFPROG="gksu meld"


### https://github.com/kazhala/dotbare
_dotbare_completion_cmd
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"



revive-mouse () {
    sudo bash -c 'echo -n "0000:08:00.3" > /sys/bus/pci/drivers/xhci_hcd/unbind'
    sudo bash -c 'echo -n "0000:08:00.3" > /sys/bus/pci/drivers/xhci_hcd/bind'
}


PATH="/home/simone/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/simone/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/simone/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/simone/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/simone/perl5"; export PERL_MM_OPT;


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# https://github.com/wfxr/forgit#git
#   - use git forgit ... to get interactive version
export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"
alias igit="git forgit"



