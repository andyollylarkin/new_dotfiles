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
        ["redos"]="rpm"
        ["ubuntu"]="deb"
        ["mint"]="deb"
    )
    local release=$(grep -Po '(?<=^ID=)[^ ]*' /etc/os-release |tr -d '"' | tr '[:upper:]' '[:lower:]');
    echo ${releases[$release]}
}

OS=$(get_os_type);

if [[ ${OS} -eq "Darwin" ]]; then
    # vscode allow vscode vim plugin movement key repeat multiple times
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
    defaults write Cursor ApplePressAndHoldEnabled -bool false
fi
