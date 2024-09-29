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
    if [[ -z $(which brew) ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if [[ $? != 0 ]]; then
            echo -e "\e[0;41mCant install brew\e[0m";
        fi
    else
        echo -e "\e[0;42mBrew already installed\e[0m";
    fi
    to_install=$@
    for app in ${to_install[@]}; do
        if [ ! -z $(which $app) ]; then
            echo -e "\e[0;42m${app} already installed\e[0m";
            continue;
        fi

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
