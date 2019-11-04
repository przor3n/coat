# make folders
mkdir ~/archive ~/bin ~/docs ~/range ~/workshops ~/library ~/temp ~/Portal ~/sync ~/junkyard


# run fzf install
sh lib/fzf/install

# add coat to .bashrc
echo "source .coat/coat.bashrc" >> ~/.bashrc

# install
gitwatch
python
php
