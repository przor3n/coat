# this is supposedly an installation file
# i write here what needs to be done

# make folders
mkdir ~/archive ~/bin ~/docs ~/range ~/workshops ~/library ~/temp ~/Portal ~/sync ~/junkyard

# pull submodules
# this will pull :
# fzf
# forgit (included in coat.sh)
git submodule update --init

# run fzf install
sh lib/fzf/install

# add coat to .bashrc
echo "source ${PATH_TO_COAT}/coat.sh" >> ~/.bashrc

# install: TODO where are 
# gitwatch
# python
# php
