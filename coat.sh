#!/bin/bash
#########################
# Startup
#########################

export PATH_TO_COAT=~/.coat

# variables go first
source $PATH_TO_COAT/modules/variables.sh

# fuzzy search
# TODO change that commented code into timing function
#start=`date +%s`
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source $PATH_TO_COAT/lib/forgit/forgit.plugin.sh
#end=`date +%s`
#runtime=$((end-start))
#echo $runtime

#########################
# autocomplete
#########################

# TODO: autocomplete causes major slowdowns
# load all files with autocomplete
#AUTOCOMPLETE_FILES="$HOME/.coat/autocomplete/*"
#for _complete__file in $AUTOCOMPLETE_FILES
#do
  # shellcheck disable=SC1090
#  source "$_complete__file"
#done


#########################
# modules
#########################

source ~/.coat/modules/bash.sh
source ~/.coat/modules/functions.sh
source ~/.coat/modules/organization.sh
source ~/.coat/modules/git.sh
source ~/.coat/modules/docker.sh
source ~/.coat/modules/python.sh
source ~/.coat/modules/coat.sh
source ~/.coat/modules/spells.sh
source ~/.coat/modules/bookmarks.sh
source ~/.coat/modules/cookiecutter.sh
source ~/.coat/modules/shortcuts.sh

# prompt is going last
# you can use stuff from other modules here
source ~/.coat/modules/prompt.sh
