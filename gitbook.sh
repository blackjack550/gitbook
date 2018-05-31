#!/bin/sh
#made by blackjack

home=/root
work_home=/root/$1


flush_gitbook(){

files=$(grep -r -l 'Published with GitBook' $work_home)
for i in ${files}
do
sed -i -e '/<li class="divider"><\/li>/,+5d' $i
done
}
build_env(){
username="$1"
desc="$2"
title="$3"
cat << EOF >$work_home/book.json
{
    "author": "$username",
    "description": "$desc",
    "extension": null,
    "generator": "site",
    "links": {
        "sharing": {
            "all": false,
            "facebook": false,
            "google": false,
            "twitter": false,
            "weibo": false
        }
    },
    "output": null,
    "pdf": {
        "fontSize": 12,
        "footerTemplate": null,
        "headerTemplate": null,
        "margin": {
            "bottom": 36,
            "left": 62,
            "right": 62,
            "top": 36
        },
        "pageNumbers": false,
        "paperSize": "a4"
    },
    "plugins": [],
    "title": "$title",
    "variables": {}
}
EOF
}
case "$1" in
	build)
		cd $work_home
		build_env "$2" "$3" "$4"	
		gitbook build
		flush_gitbook
	;;
	server)
		cd $work_home
		gitbook serve
	;;
	flush)
		flush_gitbook
	;;
	*)
	echo "Usage:$0 (flush|build|server)"
	;;
esac
