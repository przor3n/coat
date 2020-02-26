#!/bin/bash

alias watson_start='echo "Provide list of tags: "; read tags; watson projects | fzf | xargs -I{} watson start {} $tags'
alias watson_stop='watson stop'

__watson_prompt() {
	local w=''
	local status=`watson status`
	
	if [[ $status != "No project started." ]]; then
		w+=`watson status | awk '{ print $2 }'`
		echo "*[ ${w} ]*"
	else
		return
	fi
}
