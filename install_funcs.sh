#!/bin/bash

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

install_packages(){
    release=$(get_os_type);
	if [[ $release == "deb" ]]; then
		install_deb $@
	elif [[ $release == "rpm" ]]; then
		install_rmp $@
    elif [[ $release == "osx" ]]; then
        install_osx $@
	fi
}

install_osx(){
    to_install=$@
    for app in ${to_install[@]}; do
		echo "install app " $app
        brew install $app;
    done
}

install_deb(){
    to_install=$@
	for app in ${to_install[@]}; do
		echo "install app " $app
	    sudo apt install -y $app;
	done
}

install_rmp(){
    to_install=$@
    echo $to_install
	for app in ${to_install[@]}; do
		echo -e "\e[1minstall app\e[0m " $app
	    sudo dnf install -y $app;
	done
}

get_home(){
    local os_type=$(get_os_type)
    if [[ $os_type == "osx" ]]; then
        echo $HOME;
    else
	    home=$(getent passwd $1|cut -d: -f6);
	    echo $home;
    fi
}
