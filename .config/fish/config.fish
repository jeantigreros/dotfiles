if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Git configuration aliases

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


