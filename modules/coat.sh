#!/bin/bash
show_process_id () {
  ps -ef | grep $1 | awk '{print $2}'
}

open_nautilus () {
  nautilus `pwd` &>/dev/null
}

alias processids='show_process_id'
alias kknd='kill -s KILL'
alias opennautilus='open_nautilus'

alias runserver='python -m http.server 8000'
alias phpserver='php -S 127.0.0.1:8000'

alias lefthandmouse='xmodmap -e "pointer = 3 2 1"'
alias righthandmouse='xmodmap -e "pointer = 1 2 3"'

