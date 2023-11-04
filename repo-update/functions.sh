#!/bin/bash
# shellcheck disable=1091,2154,2059 # 'shellcheck source-path=SCRIPTDIR' isn't working
true

# Helper functions etc. for the dotfile repo updater script.
#
#
# thall. <thall@thallheim.com>


# GLOBALS
input_paths=()
input_paths_validated=()
dst_dirs_validated=()
inc_list="${HOME}/dotfiles/repo-update/inclusions.dat"
# UNUSED: target_root="${HOME}/dotfiles/"
# UNUSED: target_root_emacs="${HOME}/dotfiles/emacs/"

# CHECKS
src_paths_ok=false

# COLOURS
# Defined: [black, red, green, yellow, blue, cyan (plus 'reset')]
# shellcheck source=./colours.sh
source "./colours.sh"


# "ICONS" (UTF-8) & LABELS/MSG STRINGS
# [red_cross, green_checkmark, info_arrow],[error_label, info_label, warn_label]
# [info_copied_msg, error_target_newer, info_src_trgt_eq, info_diff_eq_msg]
source "./labels_strings_styles.sh"

# ERROR HANDLERS & FLAGS
source "./errors.sh"


# HELPERS
function strip_home_slug() {
    local slug="$HOME"
    local input="$1"
    local result="${input/${slug}/\~}"
    printf "%s\n" "${result}"
}

# Get, and cd to, script's dir in case it's called from elsewhere
function cd_own_dir(){
    local dir=""; dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd "$dir" || exit_fatal "DIR CHANGE FAILED"
}

get_own_dir() {
    local dir=""; dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    printf "%s" "$dir"
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
#	((error_fatal++))
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
    printf "$info_arrow"" $info_label""$bold"" Verifying sources\n""$end_bold"
    for path in "${input_paths[@]}"; do
	if [ -r "$path" ]; then
	    input_paths_validated+=("$path")
	    local path_stripped=("$(strip_home_slug "$path")")
	    printf "$green_checkmark"" $info_label"" %s\n" "${path_stripped[@]}"
	else
	    local notfound_stripped=""
	    notfound_stripped="$(strip_home_slug "$path")"
	    # TODO: Shove any error(s) into an array
	    exit_nonfatal "File not found: " "'${notfound_stripped}'"
	fi
	src_paths_ok=true
    done
}

verify_dst_paths() {
    if [ -e "${input_paths_validated[0]}" ]; then
	printf "[DBG] %s\n" "Paths exist: do not read inclusion list"
	return
    else
	printf "[DBG] %s\n" "No paths: read inclusion list"
	read_inc_list
	
    fi

    if [ ! src_paths_ok == true ]; then
	verify_src_paths
	src_paths_ok=true
    else
	return
    fi

    for path in "${input_paths_validated[@]}"; do
	local dir=$(dirname ${path})
	if [[ ! " ${input_paths_validated[@]} " =~ " $dir " ]]; then
	    dst_dirs_validated+=("$dir")
	fi
    done

    for dir in "${dst_dirs_validated[@]}"; do
    printf "[DBG] Valid dir: %s\n" "$dir"
    done
    exit_done
}


