#!/bin/bash
export TERM="screen-256color"

export PATH=$PATH:~/bin:~/.coat/lib

# History
# control whats ignored
export HISTCONTROL=ignorespace:ignoredups
# which command are ignored
export HISTIGNORE="history:ls:pwd:cd:"

# size 
export HISTSIZE=10000
export HISTFILESIZE=10000

# append every command
# export PROMPT_COMMAND="${PROMPT_COMMAND}; history -a"

# append to bash history
shopt -s histappend
