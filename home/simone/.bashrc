#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups

shopt -s histappend

PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

alias poweroff='sudo poweroff'
#alias docker='sudo docker'
#alias docker-compose='sudo docker-compose'

docker-cleanup () {
        sudo docker container prune -f --filter "until=300h"
        sudo docker image prune -f -a --filter "until=300h"
        sudo docker volume prune -f --filter "label!=keep"
        sudo docker network prune -f --filter "until=300h"
}

alias rename='perl-rename'
alias la='ls -lah'
alias tmux='systemd-run --scope --user tmux new -As0'

ugdrive () {
	local p=/home/simone/.gdrive
	rm $p/token_v2.json
	ln -s $p/$1.json $p/token_v2.json
	
	gdrive "${@:2}"	
}

eval "$(direnv hook bash)"
alias yolo="git add . && curl -s http://whatthecommit.com/index.txt | git commit -F - && git push"
