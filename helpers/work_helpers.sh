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
