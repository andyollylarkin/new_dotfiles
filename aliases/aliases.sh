#!/bin/bash


alias cls=clear
alias xclip-select='tr -d "\n"|pbcopy'

function md5sum(){
    os=$(get_os_type);
    v=$(cat /dev/stdin)
    if [[ $os == "osx" ]];then
        md5 -qs $v;
    else
        md5sum $v;
    fi
}

function code(){
    os=$(get_os_type);
    if [[ $os == "osx" ]];then
        open -a "Visual Studio Code" $*

        return 0;
    fi

    code $*
}

# GIT

alias git_last_tag='git tag --sort=-v:refname|head --lines=1'
#alias ls='ls --color'

alias git_commits_in_current_branch="cd $(pwd) && git log dev..HEAD --reverse --oneline | wc -l | xargs printf \"\033[1mCommits in $(git_current_branch): \033[0m%d\n\""

alias git_inserted_in_current_branch="cd $(pwd) && git log dev..HEAD --shortstat --oneline  --reverse |awk '/files changed/ {sum+=\$4} END {print sum}'|xargs printf '\033[31mInserted: %d\n'"
