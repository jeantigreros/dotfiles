#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias config='/usr/bin/git --git-dir=/home/j/.cfg --work-tree=/home/j'
eval "$(starship init bash)"

function ccs() {
	config status
}

function ccm() {
	config commit -m "$*"
}

function ccp() {
	config push
}

function cca() {
	config add "$*"
}
