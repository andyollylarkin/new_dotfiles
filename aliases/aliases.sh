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
    fi
}

# GIT

alias git_last_tag='git tag --sort=-v:refname|head --lines=1'
