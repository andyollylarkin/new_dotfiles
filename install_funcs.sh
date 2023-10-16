#!/bin/bash

get_os_type(){
    declare -A releases=(
        ["debian"]="deb"
        ["fedora"]="rpm"
        ["ubuntu"]="deb"
    )
    release=$(cat /etc/os-release |grep -P '^ID'|cut -d "=" -f 2);
    echo ${releases[$release]}
}


install_packages(){
    release=$(get_os_type);
	if [[ $release == "deb" ]]; then
		install_deb $@
	elif [[ $release == "rpm" ]]; then
		install_rmp $@
	fi
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
	home=$(getent passwd $1|cut -d: -f6);
	echo $home;
}
