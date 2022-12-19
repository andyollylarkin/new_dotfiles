#!/usr/bin/env bash

CURR_DIR=$(pwd);
BASH_INTERPRETER=$(which bash);

while true; do
    sudo -v;
    sleep 300;
    kill -0 "$$" || exit;
done 2>/dev/null &

to_install=(
    "terminator"
    "mc"
    "vim"
    "keepassxc"
    "curl"
    "git"
    "fonts-powerline"
);

for app in ${to_install[@]}; do
    sudo apt install -qqy $app &>/dev/null;
done

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
        echo "Install ${file}";
        ln -s $CURR_DIR/${file} ${HOME}/${file};
    fi
done

source ${HOME}/.bashrc;
unset rm_rc_files;
unset to_install;
unset CURR_DIR;
unset BASH_INTERPRETER;
kill -9 %1;

