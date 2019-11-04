#########################
# Startup
#########################

# variables go first
source ~/.coat/modules/variables.brc

# fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


#########################
# autocomplete
#########################

# load all files with autocomplete
AUTOCOMPLETE_FILES="$HOME/.coat/autocomplete/*"
for _complete__file in $AUTOCOMPLETE_FILES
do
  # shellcheck disable=SC1090
  source "$_complete__file"
done


#########################
# modules
#########################

source ~/.coat/modules/bash.brc
source ~/.coat/modules/git.brc
source ~/.coat/modules/docker.brc

source ~/.coat/modules/python.brc

source ~/.coat/modules/coat.brc
source ~/.coat/modules/spells.brc

source ~/.coat/modules/bookmarks.brc

source ~/.coat/modules/cookiecutter.brc

# prompt is going last
# you can use stuff from other modules here
source ~/.coat/modules/prompt.brc

if [ ! -n "$TMUX" ]; then
    # export TMUX=1
    tmux
fi
