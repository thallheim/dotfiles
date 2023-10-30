#!/bin/bash

# Helper functions and string for the config repo updater script.
#
#
# thall. <thall@thallheim.com>


# VARIABLES/ARRAYS

paths=()
inc_list="./inclusions.dat"
target_root="${HOME}/dotfiles/"
emacs_target_root="${HOME}/dotfiles/emacs/"


# MSG STRINGS
info_copied_msg="[INFO] Source is newer. Target updated."
error_target_newer="[ERROR] Target file is newer: Exiting..."
warn_src_trgt_eq="[INFO] Nothing to do: Source and target have identical modification times."
info_diff_eq_msg="[INFO] Nothing to do: Files up to date."

# CHECKS
inc_list_ok=false
src_paths_ok=false

# HELPERS

function strip_home_slug() {
    local home_slug="$HOME"
    local input=("$@")
    local stripped=""

    for string in "${input[@]}"; do
	if [[ $string == $home_slug* ]]; then
	    stripped+="${string#$home_slug}"
	    echo "$stripped"
	else
	    stripped+="$string"
	    echo "$string"
	fi
    done
}

function inclusion_list_exists() {
    if [[ -e "$inc_list" ]]; then
	return 0
    else
	printf "[ERROR] Could not read inclusion list:\n%s\n " "$inc_list"
	return 1
    fi
}

function check_target_paths() {
    "TODO: Not finished"
    local path="$1"
    # exists and is a dir
    if [ -e "$path" ] && [ -d "$path" ]; then
	printf "[ERROR] Path exists, but is a directory\n"
	exit 1
    # exists and isn't a dir
    elif [ -e "$path" ] && [ ! -d "$path" ]; then
	return 0
    # doesn't exist
    else
	printf "[ERROR] The path doesn't exist.\n"
	exit 1
    fi
}

function read_inc_list() {
    if [ -e "$inc_list" ]; then
	while IFS= read -r line; do
	    paths+=("$(eval echo "$line")")
	done < "$inc_list"
    else
	printf "[ERROR] Could not find inclusion list:\n'%s'\n" "$inc_list"
	exit 1
    fi
}

function verify_src_paths() {
    local result=""
    printf "[INFO] Verifying sources\n"
    for path in "${paths[@]}"; do
	if [ -e "$path" ]; then
	    result=("$(strip_home_slug "$path")")
	    printf "[INFO] OK: %s\n" "${result[@]}"
	else
	    printf "[ERROR] Requested file not found:\n'%s'\n" "$path"
	    
	fi
    done
#    printf "[INFO] OK: %s\n" "${result[@]}"
}
