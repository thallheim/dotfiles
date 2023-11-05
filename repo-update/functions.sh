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
dst_root="${HOME}/dotfiles"
# UNUSED: dst_root_emacs="${HOME}/dotfiles/emacs/"

# FLAGS
src_paths_ok=false
dst_root_writable=false

# COLOURS
# Defined: [black, red, green, yellow, blue, cyan (plus 'reset')]
source "./colours.sh"


# "ICONS" (UTF-8) & LABELS/MSG STRINGS
# [red_cross, green_checkmark, info_arrow]
# [error_label, info_label, warn_label]
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

# In case it's needed later
function get_own_dir() {
    local dir=""; dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    printf "%s" "$dir"
}

# Check that the inclusion list exists and read it into input_paths[]
function get_src_paths() {
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

# Verify src files are readable
function verify_src_paths() {
    printf "$info_arrow"" $info_label""$bold"" Verifying sources\n""$end_bold"
    for path in "${input_paths[@]}"; do
	if [ -r "$path" ]; then
	    input_paths_validated+=("$path")
	    #local path_stripped=("$(strip_home_slug "$path")")
	    #printf "$green_checkmark"" $info_label"" %s\n" "${path_stripped[@]}"
	else
	    local notfound_stripped=""
	    notfound_stripped="$(strip_home_slug "$path")"
	    # TODO: Shove any error(s) into an array
	    warn "${bold}File not found${end_bold}" "'${notfound_stripped}'"
	fi
	src_paths_ok=true
    done
}

# Verify dst root is writable
function verify_dst_root_perms() {
    if [ -w "$dst_root" ]; then
	dst_root_writable=true
	# DEBUG:
	info "${bold}Destination path writable:${end_bold} ${dst_root_writable}"
    else
	exit_fatal "${bold}Destination path writable:${end_bold} ${dst_root_writable}"
    fi
    return
}


function copy_all() {
    for file in "${input_paths_validated[@]}"; do
	cp -R "$file" "${dst_root}/temp/"
    done
}
