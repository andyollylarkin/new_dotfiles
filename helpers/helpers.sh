#!/usr/bin/env bash

# keepass masterpass
get_pass() {
    xclip --help 2>/dev/null;
    local exist_status=$?;
    if [ $exist_status == 127 ]; then
        os_type=$(get_os_type);
        echo -e "\e[41mINSTALLING XCLIP\e[0m\n"
        if [[ $os_type == "deb" ]]; then
            sudo apt-get install -qqy xclip;
        elif [[ $os_type == "rpm" ]]; then
            sudo dnf install -y xclip;
        fi
    fi
    echo -n ${1}|md5sum|grep -Eo '([A-Z]|[a-z]|[0-9])+'|tr -d "\n"|xclip -selection clipboard;
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
    which dpkg &>/dev/null;
    e_code=$?
    if [[ $e_code == 1 ]]; then
        echo "rpm";
    else
        echo "deb";
    fi
}


#------ALIASES------
alias cur_ts='date +%s';
