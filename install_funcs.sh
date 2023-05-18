#!/bin/bash

TYPE_RPM=228
TYPE_DEB=229

detect_os(){
	which dpkg 2>/dev/null;
	exit_code=$?
	if [[ exit_code == 1 ]]; then
		return $TYPE_RPM
	else
		return $TYPE_DEB
	fi
}

install_packages(){
	detect_os
	os_type=$?
	if [[ os_type == TYPE_DEB ]]; then
		install_deb $1
	else
		install_rmp $1
	fi
}


install_deb(){
	for app in ${to_install[@]}; do
		echo "install app " $app
	    sudo apt install -y $app;
	done
}

install_rmp(){
	for app in ${to_install[@]}; do
		echo -e "\e[1minstall app\e[0m " $app
	    sudo dnf install -y $app;
	done
}