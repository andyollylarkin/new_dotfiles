function git_author_stats(){
    git log --author="${1}" --pretty=tformat: --numstat|gawk '!/(vendor)/ {add += $1; subs += $2} END { printf "Added: %s\nRemoved %s\n", add, subs}'
}

function git_push_new_tag(){
    local tag=${1};
    if [ -z $tag ]; then
        echo -e "\e[0;31mTag cant be empty\e[0;m";
        return 1;
    fi
    git pull;
    git tag $tag;
    git push --tags;
}

function git_current_branch_stat(){
    branch_from=$1
    branch_to=$2;
    result=0;
    for i in $(git log ${branch_from}..${branch_to} --stat|grep -Po '(?<=\|)\s+\d+'|tr -d ' '); do 
        result=$(( result + i )); 
    done;
    unset result;
}

function add_all_ssh_keys() {
        
    for i in $(ls -d ~/.ssh/!(*config*|*pub|known_hosts|authorized_keys|*old)); do
        echo Import key: $i;
        ssh-add $i
    done
}
