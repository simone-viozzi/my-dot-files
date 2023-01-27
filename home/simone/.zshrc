
# https://github.com/romkatv/powerlevel10k#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# https://github.com/romkatv/powerlevel10k#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

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
    aliases                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases
    colored-man-pages       # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
    direnv                  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/direnv
    docker                  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
    docker-compose          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose
    dotbare                 # https://github.com/kazhala/dotbare
    extract                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract
    forgit                  # https://github.com/wfxr/forgit/issues/212
    fzf                     # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
    git
    git-auto-fetch          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-auto-fetch
    rsync                   # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync
    systemd                 # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
    tmux                    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
    zsh-autosuggestions     # https://github.com/zsh-users/zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
    # need to be at the bottom
    fzf-tab                 # https://github.com/Aloxaf/fzf-tab
)

# https://github.com/zsh-users/zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

autoload -Uz compinit && compinit
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
export PATH="$PATH:${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit/bin"

alias a='acs'
alias conf-yolo='curl -s https://whatthecommit.com/index.txt | conf commit -a -F - && conf push'
alias conf='dotbare'
alias du='echo "WARNING use dust" && du'
alias igit='git forgit'
alias la='exa -la --icons -F'
alias lg='exa -l -F --icons --git --sort=modified'
alias ls='exa --icons -F'
alias poweroff='systemctl poweroff --check-inhibitors=yes'
alias reboot='systemctl reboot --check-inhibitors=yes'
alias rename='perl-rename'
alias tree-git='exa --icons --tree --git-ignore'
alias tree='exa -F --icons --tree'
alias yolo='git add . && curl -s https://whatthecommit.com/index.txt | git commit -F - && git push'

# https://github.com/kazhala/dotbare
_dotbare_completion_cmd
_dotbare_completion_git
export DOTBARE_DIR="/.cfg"
export DOTBARE_TREE="/"

export LIBVIRT_DEFAULT_URI='qemu:///system'

eval `oidc-agent-service start` > /dev/null 2>&1

# https//github.com/ajeetdsouza/zoxide 
eval "$(zoxide init zsh)"