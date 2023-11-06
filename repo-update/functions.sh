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
dst_root="${HOME}/dotfiles/temp/"
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
    local slug_stripped="${input/${slug}}"
    local result="${slug_stripped#\/}"
    printf "%s" "${result}"
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

# TODO: Fix
# Says on the tin. Doesn't work, though :)
filter_duplicate_dst_dirs() {
    duplicates=()
    declare -A uniques=()

    for thing in "${@}"; do
	# If thing is not in the array, add and mark it as seen
	if [[ -z ${uniques["$thing"]} ]]; then
	    uniques["$thing"]=1
	else
	    # If thing is already in array, add it to duplicates array
	    duplicates+=("$thing")
	fi
  done
}

# Verify the inclusion list exists and read it into input_paths[]
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
    info_arrow "Verifying sources"
    for path in "${input_paths[@]}"; do
	if [[ -r "$path" ]]; then
	    input_paths_validated+=("$path")
	    # TODO: VERBOSE:
	    #printf "$green_checkmark"" $info_label"" %s\n" "${path_stripped[@]}"
	    local path_stripped=""
	    path_stripped="$(strip_home_slug "$path")"
	    info_checkmark "Source valid" "${path_stripped}"
	else
	    local notfound=""
	    local result=""
	    notfound="$(strip_home_slug "$path")"
	    result="${notfound/${HOME}/~}"
	    warn "${bold}[DBG] File not found${end_bold}" "'${result}'"
	fi
	src_paths_ok=true
    done
}

# TODO: Remove, probably. Feels mighty redundant.
# Verify dst root is writable 
function verify_dst_root_perms() {
    if [ -w "$dst_root" ]; then
	dst_root_writable=true
	# VERBOSE?:
	info "${bold}Destination path writable:${end_bold} ${dst_root_writable}"
    else
	exit_fatal "${bold}Destination path writable:${end_bold} ${dst_root_writable}" "$dst_root"
    fi
}

# Get folder structure from validated input paths
function get_dst_dirs() {
    for path in "${input_paths_validated[@]}"; do
	#printf "RAW PATH: %s\n" "${path}"
	local file_stripped=""
	local result=""
	file_stripped="$(dirname "$path")"

	if [[ ! "$file_stripped" = "${HOME}" ]]; then
	    result="$file_stripped"
	    
	    #for dir in "${dst_dirs_validated[@]}"; do
	    if ! [[ "${dst_dirs_validated[*]}" =~ "${result}" ]]; then
		dst_dirs_validated+=("$result")
		printf "Folder structure valid: %s\n" "$result"
	    fi
	    #done
	else
	    info_arrow "[DBG] Ignore directory" "$file_stripped"
	fi
    done
    # TODO: Later
    #dst_dirs_validated=("$(filter_duplicate_dst_dirs "${dst_dirs_validated[@]}")")
}

# Check if dst dirs exist and create as necessary
function mk_dst_dirs() {
    if [[ ! -d "$dst_root" ]]; then
	mkdir -p "${dst_root}"
	# TODO: DEBUG/VERBOSE:
	info_arrow "Created destination root folder\n"
    else
	info_checkmark "Destination root directory exists"
	#printf "$green_checkmark"" $info_label"" Destination root directory exists\n"
    fi
 
    for path in "${dst_dirs_validated[@]}"; do
	local dir=""
	dir="$(strip_home_slug "$path")"
	mkdir -p "${dst_root}${dir}"
	#printf "[DBG] Dir create: %s \n" "${dst_root}${dir}"
	info_arrow "[DBG] Dir create" "${dst_root}${dir}"
    done
}

function copy_all() {
    for src in "${input_paths_validated[@]}"; do
        # Double-check src is a file before copying
	if [[ -f "$src" ]]; then
            local dst="${dst_root}/$(strip_home_slug "$src")"
            if [[ -d "$(dirname "$dst")" ]]; then
		# Double-check dst is a dir before copying
                cp "$src" "$dst"
                info_checkmark "Copied file: $src to $dst"
            else
                printf "Destination directory %s does not exist for %s" "$(dirname "$dst")" "$src"
            fi
        else
            warn "Source file does not exist or is not a regular file" "$src"
        fi
    done
}
