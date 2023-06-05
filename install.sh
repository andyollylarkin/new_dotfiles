#!/usr/bin/env bash


user=$(whoami)
if [[ $user != 'root' ]]; then
	echo -e "\033[101mPlease use with sudo!\033[0m"
	exit 1;
fi

source ./install_funcs.sh

CURR_DIR=$(pwd);
BASH_INTERPRETER=$(which bash);
HOME=$(get_home $SUDO_UID);

to_install=(
    "terminator"
    "mc"
    "vim"
    "keepassxc"
    "curl"
    "git"
    "fonts-powerline"
    "powerline-fonts" #for rpm based systems
);

echo -e "\033[101mInstalling packages\033[0m"
#install_packages

#install oh-my-bash
if [ ! -d ${HOME}/.oh-my-bash ]; then
    $BASH_INTERPRETER -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)";
else
    echo -e "\033[101mOh-my-bash already installed\033[0m"
fi

# install rc files
rm_rc_files=(
    ".vimrc"
    ".bashrc"
    ".inputrc"
    ".curlrc"
);

#remove *rc files if exists
echo "Remove rcfiles";
for file in ${rm_rc_files[@]}; do
    if [ -f ${HOME}/${file} ]; then
        echo "Remove ${file}";
        rm ${HOME}/${file};
    fi
done

echo "Install rcfiles";
rcfiles=($(ls -a|grep -P '^(?!\.git)\.\w+'));
for file in ${rcfiles[@]}; do
    if [ ! -f ${HOME}/${file} ]; then
        echo "Install ${file}. Dst path: ${HOME}/${file}";
        ln -s $CURR_DIR/${file} ${HOME}/${file};
    fi
done

source ${HOME}/.bashrc;
unset rm_rc_files;
unset to_install;
unset CURR_DIR;
unset BASH_INTERPRETER;
