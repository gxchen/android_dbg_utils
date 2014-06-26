#!/bin/bash

# A helper script for pushing change to gerrit using 'git push'

# qitpush <project> <branch>


get_project_info_by_name()
{
	[ -z "$1" ] && return

	echo "project name: $1"
}

get_default_revision()
{
	local _default_revision=$(grep -E "<default" -A2 ${MANIFEST_FILE} | grep "revision" | cut -d'=' -f2 | cut -d' ' -f1 | tr -d \")

	echo "${_default_revision}"
}

get_cur_project_revision()
{
	local _cur_project_revision=$(echo )

	echo "${_cur_project_revision}"
}

###############
# main
###############
MANIFEST_FILE='.repo/manifest.xml'

REVISION=$(get_cur_project_revision)
if [ -z "$REVISION" ]; then
	REVISION=$(get_default_revision)
fi

echo "[DBG]  revision: $REVISION"

# read -p "Go ahead? <CTRL+C> to exit..." dummy

echo "hello,world"
# git push ....
