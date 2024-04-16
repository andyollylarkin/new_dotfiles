#!/usr/bin/env bash

# keepass masterpass
get_pass() {
    xclip --help 2>/dev/null;
    local exist_status=$?;
    local os_type=$(get_os_type)
    if [[ $exist_status == 127 && $os_type != "osx" ]]; then
        echo -e "\e[41mINSTALLING XCLIP\e[0m\n"
        if [[ $os_type == "deb" ]]; then
            sudo apt-get install -qqy xclip;
        elif [[ $os_type == "rpm" ]]; then
            sudo dnf install -y xclip;
        fi
    fi
    echo -n ${1}|md5sum|grep -Po '(\d|\w){32}'|tr -d '\n'|xclip-select;
}

#-----USER_FUNCTIONS----
function remove(){
    if [[ $1 == 'clean' ]]; then
        rm -Rfv /tmp/will_removed 1>/dev/null;
        sync;
        echo -e "\e[1;31m________CLEAN COMPLETE________\e[0m\n";
        return 0;
    fi
    local params=$@;
    local rmd='/tmp/will_removed' &>/dev/null;
    if [ ! -d $rmd ]; then
        mkdir $rmd;
    fi
    mv -f ${params} ${rmd} 1>/dev/null;
}

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

function tmux_attach(){
    if [ -z $TMUX ]; then
        # checks if has already attached clients to "main" session. If connected, create a new session. (vscode terminal use case).
        if [ $(tmux list-clients -t main|wc -l) -ge 1 ]; then
            tmux new-session
            return 0
        fi
        tmux attach-session -t main || tmux new-session -s main
    fi
}


#------ALIASES------
alias cur_ts='date +%s';
