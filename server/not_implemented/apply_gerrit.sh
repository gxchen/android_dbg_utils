#!/bin/bash

Gerrit_port="29418"
Gerrit_url="review-android.quicinc.com"

User="$USER"

# extract from 'gettop()' in '. build/envsetup.sh'
get_top_dir() {
	local TOPFILE=build/core/envsetup.mk

	if [ -f $TOPFILE ]; then
		PWD= /bin/pwd
	else
		local HERE=$PWD;
		T=;
		while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
			\cd ..;
			T=`PWD= /bin/pwd`;
		done;
		\cd $HERE;
		if [ -f "$T/$TOPFILE" ]; then
			echo $T;
		fi;
	fi;
}

# make sure './repo/manifest.xml' exists
# we get project path from project name, from manifest.xml 
check_manifest_file() {
	if [[ -f "$android_root/.repo/manifest.xml" ]]; then
		echo "[DBG] manifest file exists."
		return 0
	fi

	echo "[ERR] can't find manifest.xml."
	return 1
}

# user may input a file with gerrits, or just one single gerrit.
# we need to support both of them.
parse_input_args() {

	# only support one arg currently.
	if [[ "$#" -ne 1 ]]; then
		echo "[ERR] wrong args, only one arg is supported"
		return 1
	fi

	if [[ -f "$1" ]]; then
		echo "[DBG] read gerrits from file: $1"
	else
		echo "[DBG] direct get gerrit no from parm: $1"
	fi

	return 0
}


# we need to copy the gerrit list to a temp file
# and delete each line as soon as we have done cherry-picked it.
# Thus, we can start from when we leave, if meeting any errors during merging...
copy_gerrit_list() {
	cp $1 /tmp/$1.tmp

	return 0
}

extract_gerrit_no() {
    gerrit_no="$(echo "$1" | grep -E -o "[0-9]{6}")"
    echo "[DBG] input param: $1, return gerrit_no: $gerrit_no"
}

run_query() {
	result=$(ssh -p $Gerrit_port ${User}@${Gerrit_url} gerrit query --current-patch-set $1)
#	echo "ssh -p $Gerrit_port ${User}@${Gerrit_url} gerrit query --current-patch-set $1"
#	echo "$result"

}

query_a_gerrit() {
    extract_gerrit_no "$1"

	run_query $gerrit_no
}

parse_query_result() {
	refs=$(echo "$result" | grep "ref:" | awk '{print $2}')
	project=$(echo "$result" | grep "project" | awk '{print $2}')

	echo "[DBG] ### parse query result:"
	echo "[DBG] refs: $refs, project: $project"
	return 0
}

# patches are at different pathes,
# we need to `cd` to the project root dir first
get_project_path() {

	# now we simply 'grep' the manifest.xml file
	# it's better to parse the xml tree, using python for example

	echo "[ERR] must parse xml file!!!!"
	exit -1

	__path=$(grep -E "$project" $android_root/.repo/manifest.xml -A2 | grep "path=" | cut -d'=' -f2 | cut -d'"' -f2)

	echo "[DBG] $project ==> $__path"

	return 0
}

make_cherrypick_cmd() {
	cherry_pick_cmd="git fetch ssh://${USER}@${Gerrit_url}:${Gerrit_port}/${project} ${refs} && git cherry-pick FETCH_HEAD"
	echo "[DBG] command: $cherry_pick_cmd"
}

do_cherrypick() {
	echo "[DBG] running cherry pick command..."
	eval "$cherry_pick_cmd"
	return 0
}


android_root="$(get_top_dir)"
if [ -z "$android_root" ] ; then
	echo "[ERR] can't find android root dir, are you sure in src code of android???"
	exit 1
fi

if ! check_manifest_file ; then
	echo "[ERR] can't find manifest file."
	exit 1
fi

echo "input params: ($#) $@"

parse_input_args $@

query_a_gerrit $1

parse_query_result

get_project_path
\cd $android_root/$__path
pwd

make_cherrypick_cmd
do_cherrypick




