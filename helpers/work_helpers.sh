#!/usr/bin/env bash

set -o pipefail

function git_author_stats(){
    local authors_regexp="";
    for i in ${@}; do
        authors_regexp+='\|%s';
    done
    authors_regexp=$(echo $authors_regexp|cut -c 3-)
    git log --author="$( printf ${authors_regexp} ${@})" --pretty=tformat: --numstat|gawk '!/(vendor)/ {add += $1; subs += $2} END { printf "Added: %s\nRemoved %s\n", add, subs}'
}

function git_push_new_tag(){
    local tag=${1};
    if [ -z $tag ]; then
        echo -e "\e[0;31mTag cant be empty\e[0;m";
        return 1;
    fi
    git pull;
    git tag $tag;
    git push --tags;
}

function git_current_branch_stat(){
    branch_from=$1
    branch_to=$2;
    result=0;
    for i in $(git log --stat ${branch_from}..${branch_to}|grep -Po '(?<=\|)\s+\d+'|tr -d ' '); do 
        result=$(( result + i )); 
    done;
    unset result;
}

function add_all_ssh_keys() {
    for i in $(ls -d ~/.ssh/!(*config*|*pub|known_hosts|authorized_keys|*old)); do
        echo Import key: $i;
        ssh-add $i
    done
}


function is_cert_selfsigned() {
    cert_path=${1}
    mapfile -t vars < <(openssl x509 -in  ${cert_path} -subject -issuer -noout | grep -Po '(?<=CN\=)\w+')
    if [[ ${#vars[@]} > 2 ]]; then
        echo "Invalid issuer or subject of ${cert_path}";
        return 2;
    fi

    if [[ ${vars[0]} == ${vars[1]} ]]; then
        echo "${cert_path} IS SELF SIGNED;"
    else
        echo "${cert_path} IS NOT SELF SIGNED!";
    fi

    return 0;
}