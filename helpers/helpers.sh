#!/usr/bin/env bash

# keepass masterpass
get_pass() {
    xclip --help 2>/dev/null;
    local exist_status=$?;
    if [ $exist_status == 127 ]; then
        echo -e "\e[41mINSTALLING XCLIP\e[0m"
        sudo apt-get install -qqy xclip;
    fi
    echo -n ${1}|md5sum|grep -Eo '([A-Z]|[a-z]|[0-9])+'|tr -d "\n"|xclip -selection clipboard;
}
