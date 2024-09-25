#!/usr/bin/env bash

function lkubectl() {
    CONFIG=$(dirname $BASH_SOURCE)
    KUBECONFIG=${CONFIG}/config kubectl --insecure-skip-tls-verify=true $@;
}
