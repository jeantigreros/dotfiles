if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Git configuration aliases

function dotfiles --description "dotfiles commands with bare git repo"
    GIT_WORK_TREE=~ GIT_DIR=~/.cfg/ $argv
end

function config
    /usr/bin/git --git-dir=/home/j/.cfg --work-tree=/home/j $argv
end

function ccs 
    config status
end

function ccm 
    config commit -m "$argv"
end

function ccp 
    config push
end

function cca 
    config add $argv
end

function ggs 
    git status
end

function ggm 
    git commit -m "$argv"
end

function ggp 
    git push
end

function gga 
    git add $argv
end

source "$HOME/.cargo/env.fish"

export EDITOR="nvim"
