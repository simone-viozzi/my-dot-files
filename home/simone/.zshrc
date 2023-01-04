# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/simone/.zshrc'

# End of lines added by compinstall


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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

source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
	zsh-autosuggestions	# https://github.com/zsh-users/zsh-autosuggestions
	forgit			# https://github.com/wfxr/forgit/issues/212
	colored-man-pages	# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
	docker			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
	docker-compose		# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
	aliases			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases
	dotbare			# https://github.com/kazhala/dotbare
	fzf			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
	fzf-tab			# https://github.com/Aloxaf/fzf-tab
	tmux			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
	systemd			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
	rsync                   # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync
	git-auto-fetch          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch
	extract			# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
	zsh-z 			# https://github.com/agkozak/zsh-z
)

# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

autoload -Uz compinit
compinit

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# https://github.com/wfxr/forgit#git
#   - use git forgit ... to get interactive version
export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"

alias rename='perl-rename'
alias igit="git forgit"
alias yolo='git add . && curl -s https://whatthecommit.com/index.txt | git commit -F - && git push'
alias conf='dotbare'
alias conf-yolo='curl -s https://whatthecommit.com/index.txt | conf commit -a -F - && conf push'
alias a='acs'
alias du='echo "WARNING use dust" && du'
alias ls='exa --icons -F'
alias la='exa -la --icons -F'
alias lg='exa -l -F --icons --git --sort=modified'
alias tree='exa -F --icons --tree'
alias tree-git='exa --icons --tree --git-ignore'
alias poweroff='systemctl poweroff --check-inhibitors=yes'
alias reboot='systemctl reboot --check-inhibitors=yes'

export DOTBARE_DIR="/.cfg"
export DOTBARE_TREE="/"

json() {
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

jsonl() {
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

export LIBVIRT_DEFAULT_URI='qemu:///system'

eval `oidc-agent-service start` > /dev/null 2>&1

