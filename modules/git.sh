#!/bin/bash

auto-commit() {
      gitwatch.sh -l 2 $(pwd) &>/dev/null &disown
      echo $! > .autosave
}

alias branch='git rev-parse --abbrev-ref HEAD 2> /dev/null'

alias git-autocommit='auto-commit'
alias show-autocommit='ps ax | grep gitwatch.sh'
alias stop-autocommit='kill -s KILL $(cat .autosave) && rm .autosave'
alias stop-commits=''


find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

# fuzzy search for git commands
export GIT_COMMANDS_FILE=~/.coat/git_commands

unalias kit 2> /dev/null
kit() {
   local dest_dir=$(cat $GIT_COMMANDS_FILE | fzf )
   if [[ $dest_dir != '' ]]; then
      coms = $(echo $dest_dir | tr "#" " ")
      `$dest_dir`
   fi
}
export -f kit > /dev/null


PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
        branch=$(echo "$branches" |
                     fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
    local tags branches target
    branches=$(
        git --no-pager branch --all \
            --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
            | sed '/^$/d') || return
    tags=$(
        git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
    target=$(
        (echo "$branches"; echo "$tags") |
            fzf --no-hscroll --no-multi -n 2 \
                --ansi) || return
    git checkout $(awk '{print $2}' <<<"$target" )
}

alias makeworking='git checkout -b working'
alias removeworking='git branch -D working'
alias setcurrentbranch='export CURRENT_BRANCH=$git_branch'

alias startnewwork='setcurrentbranch; removeworking; makeworking;'
alias startnewbranch='git checkout -b $1'

alias showgitlogs='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias squashcurrent='git rebase -i $(showgitlogs|fzf|awk "{ print $2 }")'












# recite 'about-alias'
# about-alias 'common git abbreviations'

# Aliases
alias gcl='git clone'
alias ga='git add'
alias grm='git rm'
alias gap='git add -p'
alias gall='git add -A'
alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'
alias gfv='git fetch --all --prune --verbose'
alias gftv='git fetch --all --prune --tags --verbose'
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias gm="git merge"
alias gmv='git mv'
alias g='git'
alias get='git'
alias gs='git status'
alias gss='git status -s'
alias gsu='git submodule update --init --recursive'
alias gl='git pull'
alias glum='git pull upstream master'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gpu='git push --set-upstream'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gpom='git push origin master'
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias gd='git diff'
alias gds='git diff --staged'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v -m'
alias gcam="git commit -v -am"
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'
alias gbt='git branch --track'
alias gbm='git branch -m'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpx='git cherry-pick -x'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gcob='git checkout -b'
alias gct='git checkout --track'
alias gcpd='git checkout master; git pull; git branch -D'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"
alias gt="git tag"
alias gta="git tag -a"
alias gtd="git tag -d"
alias gtl="git tag -l"
alias gpatch="git format-patch -1"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
alias ggui="git gui"
alias gcsam="git commit -S -am"
alias gst="git stash"
alias gstb="git stash branch"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gh='cd "$(git rev-parse --show-toplevel)"'
# Show ignored files
alias gi='git ls-files . --ignored --exclude-standard --others'
# show untracked files
alias gu='git ls-files . --exclude-standard --others'

alias gsa='git submodule add'
alias gtls='git tag -l | sort -V'

