#!/bin/bash

#################################
# simplify git push...
#################################


####################################################################
# print out colorful chars on terminal

SETCOLOR_NORMAL="echo -en \\033[0;39m"
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_DEBUG="echo -en \\033[1;35m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"

TXT_RED() {
     $SETCOLOR_FAILURE && echo -en "$1" && $SETCOLOR_NORMAL
}

TXT_YELLOW() {
     $SETCOLOR_WARNING && echo -en "$1" && $SETCOLOR_NORMAL
}

TXT_GREEN() {
     $SETCOLOR_SUCCESS && echo -en "$1" && $SETCOLOR_NORMAL
}

TXT_PURPLE() {
     $SETCOLOR_DEBUG && echo -en "$1" && $SETCOLOR_NORMAL
}

####################################################################





GIT_PUSH_URL="ssh://gaochen@review-android.quicinc.com:29418"


usage () {
	echo "[INF] Usage:"
	echo  -n "[INF]     " && TXT_YELLOW "gp.sh  -b  <branch-name>" && echo -e "\n"
}

# we'd better check whether the branch is valid or not,
# currently only return 0, that means not check...
is_brach_valid () {
	return 0
}

# if user don't specify a branch,
# we should use a **DEFAULT** branch from manifex.xml
parse_args () {

	if [[ "$#" -ne 2 ]]; then
		echo "[ERR] incorrect args" && usage
		exit
	fi

	if [ ! "$1" == "-b" ] ; then
		echo "[ERR] incorrect args" && usage
		exit
	fi

	# echo "[DBG] branch-name: $2"
	if ! is_brach_valid $2 ; then
		echo "[ERR] invalid branch: $2"
		exit
	fi

	branch_name="$2"
}

main() {

	branch_name="LNX.LA.3.7"
	parse_args $@


	project_name="$(git remote -v | grep push | awk '{print $2}' | cut -d'/' -f4-)"

	echo "pushing to:"
	echo -n "    project  -->  " && TXT_YELLOW "$project_name" && echo
	echo -n "    branch   -->  " && TXT_YELLOW "$branch_name"  && echo

	TXT_PURPLE "running: " && echo "git push ${GIT_PUSH_URL}/${project_name}.git HEAD:refs/for/$branch_name"


	TXT_RED "Go ahead? <press any key>"
	read dev_null

	git push ${GIT_PUSH_URL}/${project_name}.git HEAD:refs/for/$branch_name

	return 0
}


main $@


