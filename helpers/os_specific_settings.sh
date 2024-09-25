#!/usr/bin/env bash

get_os_type(){
    local is_darwin=$(uname -s)
    if [[ $is_darwin == "Darwin" ]];then
        echo "osx";
        return
    fi
    declare -A releases=(
        ["debian"]="deb"
        ["fedora"]="rpm"
        ["ubuntu"]="deb"
        ["mint"]="deb"
    )
    local release=$(cat /etc/os-release |grep -P '^ID'|cut -d "=" -f 2|tr '[:upper:]' '[:lower:]');
    echo ${releases[$release]}
}

OS=$(get_os_type);

if [[ ${OS} -eq "Darwin" ]]; then
    # vscode allow vscode vim plugin movement key repeat multiple times
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
fi
