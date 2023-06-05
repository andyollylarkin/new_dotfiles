#!/usr/bin/env bash

alias dep_prod="dep deploy --hosts='prod' --branch='master'"
alias sshi="ssh -o IdentitiesOnly=yes"
alias workssh="sshpass -p 12344 ssh -o IdentitiesOnly=yes $1"
