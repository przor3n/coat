#!/bin/bash
# a hack for virtual envs from Makefile
export VENV_FOLDER=".venv"

alias switchpython='sudo update-alternatives --config python'

alias makevenv='virtualenv $VENV_FOLDER'

alias makeactive='source $VENV_FOLDER/bin/activate'

# go up folder recursevly and find virtual env to activate
alias makeactiver='mark; current_dir=`pwd`;while [ $current_dir != "/" ]; do source $current_dir/.venv/bin/activate && break || cd .. && current_dir=`pwd`; done; goto'

alias installrequirements='pip install -r requirements.txt'

alias black='black -Sq'
