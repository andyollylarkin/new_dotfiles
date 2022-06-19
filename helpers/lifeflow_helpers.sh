#!/usr/bin/env bash

function decision(){
    declare -a rand_res;
    local decision=$((1 + $RANDOM % 10));
    for i in {1..11}; do
        rand_res[$i]=$((1 + $RANDOM % 10));
    done
    for i in ${rand_res[@]}; do
        decision=$i;
    done
    if [ $decision -gt 5 ]; then echo 'Yes'; else echo 'No'; fi
}
