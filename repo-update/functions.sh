#!/bin/bash

# Helper functions and strings for the config repo updater script.
#
#
# thall. <thall@thallheim.com>


# VARIABLES/ARRAYS

input_paths=()
inc_list="./inclusions.dat"
target_root="${HOME}/dotfiles/"
emacs_target_root="${HOME}/dotfiles/emacs/"

# COLOURS
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

# MSG STRINGS
red_cross="$red""\xE2\x9D\x8C""$reset"
green_checkmark="$green""\xE2\x9C\x93""$reset"
error_label="[$red""ERROR""$reset""]"
info_label="[$cyan""INFO""$reset""]"
warn_label="[$yellow""WARN""$reset""]"

info_copied_msg="$info_label"" Source is newer. Target updated."
error_target_newer="$error_label"" Target file is newer: Exiting..."
info_src_trgt_eq="$info_label"" Nothing to do: Source and target have identical modification times."
info_diff_eq_msg="$info_label"" Nothing to do: Files up to date."


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
	printf "$red""\xE2\x9D\x8C""$reset"" [$red""ERROR""$reset""]"" Could not read inclusion list:\n%s\n " "$inc_list"
	return 1
    fi
}

function check_target_paths() {
    "TODO: Not finished"
    local path="$1"
    # exists and is a dir
    if [ -e "$path" ] && [ -d "$path" ]; then
	printf "$red""\xE2\x9D\x8C""$reset"" [$red""ERROR""$reset""]"" Path exists, but is a directory\n"
	exit 1
    # exists and isn't a dir
    elif [ -e "$path" ] && [ ! -d "$path" ]; then
	return 0
    # doesn't exist
    else
	printf "$red""\xE2\x9D\x8C""$reset"" [$red""ERROR""$reset""]"" The path doesn't exist.\n"
	exit 1
    fi
}

function read_inc_list() {
    if [ -e "$inc_list" ]; then
	while IFS= read -r line; do
	    input_paths+=("$(eval echo "$line")")
	done < "$inc_list"
    else
	printf "$red""\xE2\x9D\x8C""$reset"" [$red""ERROR""$reset""]"" Could not find inclusion list:\n'%s'\n" "$inc_list"
	exit 1
    fi
}

function verify_src_paths() {
    local result=""
    printf "[$cyan""INFO""$reset""] Verifying sources\n"

    for path in "${input_paths[@]}"; do
	if [ -e "$path" ]; then
	    result=("$(strip_home_slug "$path")")
	    printf "$green""\xE2\x9C\x93""$reset""$info_label"" %s\n" "${result[@]}"
	else
	    printf "%s File not found: " "${error_label}"
	    printf "'%s'\n" "${path}"
	fi
    done

}
