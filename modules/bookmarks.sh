#!/bin/bash
export SPOT_FILE=~/.coat/storage/spot
alias mark='pwd > $SPOT_FILE'
alias spot='cat $SPOT_FILE'
alias goto='cd `spot`'

# folder bookmarks
export FOLDER_BOOKMARK_FILE=~/.coat/storage/bookmarks
alias bookmarkfolder='pwd >> $FOLDER_BOOKMARK_FILE'

# fuzzy search for 
alias cdg='cat $FOLDER_BOOKMARK_FILE | fzf'
unalias cdg 2> /dev/null
cdg() {
   local dest_dir=$(cat $FOLDER_BOOKMARK_FILE | fzf )
   if [[ $dest_dir != '' ]]; then
      cd "$dest_dir"
   fi
}
export -f cdg > /dev/null
