#!/bin/bash
export MAGI_BOOK=~/.coat/storage/magi_book
unalias spell_find 2>/dev/null                                                 

spellcast() {                                                                      
    eval "`cat $MAGI_BOOK | fzf`"                                                        
}                                           
alias sp='spellcast'


ansible_command() {
    #host=$(ansible-inventory -y --list | while read -r line; do echo $line; done | sed -e 's/:.*//g'|fzf)	
    playbook=$(find ~/docs/systems/playbooks -type f -name "*.yml" | fzf)
    ansible-playbook --ask-become-pass $playbook
}
export ansible_command


fman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}

z() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}


fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}



spellsave () {
    history | fzf | awk -e '{ $1=""; print $0 }' >> $MAGI_BOOK
}

alias spelledit='nano $MAGI_BOOK'

alias linkdocs='find ~/docs/ -path *.git -prune -o -type f -print | fzf | xargs ln -s'
alias vdocs='find ~/docs/ -path *.git -prune -o -type f -print | fzf | xargs vim'
alias putgitignore='find ~/libraly/gitignores -path *.git -prune -o -type f -print | fzf | xargs -I{} cp "{}" . '
alias fmans='fman'


