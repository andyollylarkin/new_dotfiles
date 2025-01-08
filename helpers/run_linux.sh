#!/usr/bin/env bash

function run_linux() {
    if [[ ! $1 =~ '.qcow2' ]]; then
        echo "Invalid image format. Pass qcow2";
        return 2;
    fi
    qemu-system-x86_64 -hda  $1  -m 4096 -smp 2 -net nic,model=rtl8139 -net user,hostfwd=tcp::2222-:22 -nographic;
}
