#!/bin/bash
#########################
# Startup
#########################

export PATH_TO_COAT=`pwd | xargs dirname`

# variables go first
#start=`date +%s`
source ~/.coat/modules/variables.sh
#end=`date +%s`
#runtime=$((end-start))
#echo $runtime


# fuzzy search
#start=`date +%s`
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.coat/lib/forgit/forgit.plugin.sh
#end=`date +%s`
#runtime=$((end-start))
#echo $runtime

#########################
# autocomplete
#########################

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
source ~/.coat/modules/organization.sh
source ~/.coat/modules/git.sh
source ~/.coat/modules/docker.sh
source ~/.coat/modules/python.sh
source ~/.coat/modules/coat.sh
source ~/.coat/modules/spells.sh
source ~/.coat/modules/bookmarks.sh
source ~/.coat/modules/cookiecutter.sh
source ~/.coat/modules/shortcuts.sh
# if [ ! -n "$TMUX" ]; then
#    export TMUX=1
#    tmux
# fi

# prompt is going last
# you can use stuff from other modules here
source ~/.coat/modules/prompt.sh
