#!/usr/bin/env bash

function _shell_buff_replace(){
    local OLD_BUFF=$READLINE_LINE;
    if [ -z "${OLD_BUFF}" ]; then
        return;
    fi
    if [ "${OLD_BUFF:0:4}" != 'sudo' ]; then
        READLINE_LINE="sudo $OLD_BUFF";
        READLINE_POINT=$((${#READLINE_LINE}+1));
    fi
}
bind -m emacs -x '"\006":_shell_buff_replace'
bind -m vi -x '"\006":_shell_buff_replace'
