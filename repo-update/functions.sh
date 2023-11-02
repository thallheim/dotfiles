#!/bin/bash

# Helper functions etc. for the dotfile repo updater script.
#
#
# thall. <thall@thallheim.com>


# ARGV
arg1="$1"


# GLOBALS
input_paths=()
#inc_list="${HOME}/dotfiles/repo-update/TESTING_AND_SUCH_MMMKAY"
inc_list="${HOME}/dotfiles/repo-update/inclusions.dat"
# UNUSED: target_root="${HOME}/dotfiles/"
# UNUSED: emacs_target_root="${HOME}/dotfiles/emacs/"


# COLOURS
#
# Using `tput`. Named colours are:
# black, red, green, yellow, blue, cyan, plus 'reset'
source "./colours.sh"


# "ICONS" (UTF-8) & LABELS/MSG STRINGS
#
# red_cross, green_checkmark, info_arrow
# error_label, info_label, warn_label
# info_copied_msg, error_target_newer, info_src_trgt_eq, info_diff_eq_msg
source "./labels_strings_styles.sh"


# ERROR FLAGS
# UNUSED: opt_print_error_details=false
error_nonfatal=0
error_fatal=0


# HELPERS
function strip_home_slug() {
    local slug="$HOME""/"
    local input="$1"
    local result="${input/${slug}}"
    printf "%s\n" "${result}"
}

#function check_target_paths() {
#    "TODO: Not finished"
#    local path="$1"
#    # exists and is a dir
#    if [ -e "$path" ] && [ -d "$path" ]; then
#	printf "$error_label"" Path exists, but is a directory\n"
#	error_fatal=1
#    # exists and isn't a dir
#    elif [ -e "$path" ] && [ ! -d "$path" ]; then
#	return 0
#    # doesn't exist
#    else
#	printf "$error_label"" Invalid path: "
#	printf "%s\n" "${path}"
#	let "error_fatal++"
#    fi
#}

function read_inc_list() {
    if [ -e "$inc_list" ]; then
	while IFS= read -r line; do
	    input_paths+=("$(eval echo "$line")")
	    # TODO: Remove: Debug only
	    #printf "[DBG]: %s\n" "$line"
	done < "$inc_list"
    else
	exit_fatal "Could not read inclusion list: " "$inc_list"
    fi
}

function verify_src_paths() {
    local result=""
    printf "$info_arrow"" $info_label""$bold"" Verifying sources\n""$end_bold"

    for path in "${input_paths[@]}"; do
	if [ -e "$path" ]; then
	    path_stripped=("$(strip_home_slug "$path")")
	    printf "$green_checkmark"" $info_label"" %s\n" "${path_stripped[@]}"
	else
	    # TODO: Shove any error(s) into an array
	    exit_nonfatal "File not found: " "'${path}'"
	fi
    done
}

function print_error_count() {
    local err_count="$(($error_fatal + $error_nonfatal))"

    printf "\nErrors total:\t%d""$err_count"
    printf "\n"
    printf " %s Fatal:\t%d\n" '-' "$error_fatal"
    printf " %s Non-fatal:\t%d\n" '-' "$error_nonfatal"
    printf "\n"
}

function exit_done() {
    printf "\n$info_arrow"" $info_label""$bold"" Done. Exiting...\n""$end_bold"
    exit 0
}

function exit_nonfatal() {

    let "error_nonfatal++"
    printf "$warn_triangle $warn_label ${bold}Finished, but encountered non-fatal error(s):\n${end_bold}"
    printf "\t%s %s %s\n" "  -" "$1" "$2"

    # Check whether to display error counter
    if [ "$arg1" = "-ec" ]; then
	print_error_count
    fi
    exit_done
}


function exit_fatal() {
    # Print error, increment error counter
    printf "$red_cross $error_label "
    printf "%s %s\n" "$1" "$2"
    let "error_fatal++"

    # Check whether to display error counter
    if [ "$arg1" = "-ec" ]; then
	print_error_count
    fi
    exit 1
}
