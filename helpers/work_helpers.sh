function git_author_stats(){
    git log --author="${1}" --pretty=tformat: --numstat|gawk '!/(vendor)/ {add += $1; subs += $2} END { printf "Added: %s\nRemoved %s\n", add, subs}'
}
