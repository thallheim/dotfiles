#!/bin/bash
# shellcheck disable=1001,1091,2154,2059 # 'shellcheck source-path=SCRIPTDIR' isn't working
true

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


# FUNCTIONS

#Defined in `labels_strings_styles.sh`
function show_help() {
    printf "${usage}"
    printf "${opts}"
}

function strip_home_slug() {
    local input="$1"
    local slug_stripped="${input/${HOME}}"
    local result="${slug_stripped#\/}"
    printf "%s" "${result}"
}

function strip_slug() {
    local input="$1"
    local result=""

    if [[ $input == ${HOME}\/* ]]; then
	local subst="~"
	sed -r "s#${HOME}#${subst}#" <<< "$input"
    fi
}

function shorten_slug() {
    local input="$1"
    local result=""

    if [[ $input == ${HOME}* ]]; then
	local subst="~"
	sed -r "s#${HOME}#${subst}#" <<< "$input"
    fi
    
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

# Verify the inclusion list exists and read it into input_paths[]
function get_src_paths() {
    if [ -e "$inc_list" ]; then
	while IFS= read -r line; do
	    input_paths+=("$(eval echo "$line")")
	done < "$inc_list"
    else
	exit_fatal "Could not read inclusion list: " "$inc_list"
    fi
}

# Verify src files are readable
function verify_src_readable() {
    info_arrow "Verifying sources"
    for path in "${input_paths[@]}"; do
	if [[ -r "$path" ]]; then
	    input_paths_validated+=("$path")
	    local path_stripped=""
	    path_stripped="$(shorten_slug "$path")"
	    # TODO: VERBOSE:
	    info_checkmark "Valid" "${path_stripped}"
	else
	    local notfound=""
	    local result=""
	    notfound="$(shorten_slug "$path")"
	    result="${notfound/${HOME}/~}"
	    warn "${bold}File not found${end_bold}" "'${result}'"
	fi
	
	# Make sure at least one src file is readable, otherwise just exit
	# TODO: Implement the actual check
	if [[ ! "${#input_paths_validated[@]}" -gt 0 ]]; then
	    exit_fatal "Failed to read sources. Check permissions if files are known good."
	    src_paths_ok=false
	fi
    done
}

# Get folder structure from validated input paths
function get_dst_dirs() {
    for path in "${input_paths_validated[@]}"; do
	#printf "RAW PATH: %s\n" "${path}"
	local file_stripped=""
	local result=""
	file_stripped="$(dirname "$path")"

	# If it's not the home folder itself, process it
	if [[ ! "$file_stripped" = "${HOME}" ]]; then
	    result="$file_stripped"
	    
	    # Only add the path if it isn't already in the array
	    if ! [[ "${dst_dirs_validated[*]}" =~ "${result}" ]]; then
		dst_dirs_validated+=("$result")
		# TODO: Debug
		#printf "Folder structure valid: %s\n" "$result"
	    fi
	#else
	#    info_arrow "[DBG] Ignore directory" "$file_stripped"
	fi
    done
}

# Check if dst dirs exist and create as necessary
function mk_dst_dirs() {
    if [[ ! -d "$dst_root" ]]; then
	mkdir -p "${dst_root}"
	# TODO: DEBUG/VERBOSE:
	info_arrow "Created destination root folder"
    else
	info_checkmark "Destination root directory exists"
	#printf "$green_checkmark"" $info_label"" Destination root directory exists\n"
    fi
 
    for path in "${dst_dirs_validated[@]}"; do
	local dir=""
	dir="$(strip_home_slug "$path")"
	mkdir -p "${dst_root}${dir}"
	info_arrow "[DBG] Dir create" "${dst_root/${HOME}/\~}${dir}"
    done
}

function copy_all() {
    for src in "${input_paths_validated[@]}"; do
        # Double-check src is a file before copying
	if [[ -f "$src" ]]; then
	    local dst=""
            dst="${dst_root}$(strip_home_slug "$src")"
            if [[ -d "$(dirname "$dst")" ]]; then
		# Double-check dst is a dir before copying
                cp "$src" "$dst"
                # TODO: DEBUG/VERBOSE
		printf "$green_checkmark $info_label""Copy: %s ${cyan}->${reset} %s\n" "$(shorten_slug "${src}")" "$(shorten_slug "${dst}")"
            else
		warn "Skipped file '%s': Destination directory doesn't exist (%s)" "$src" "$(dirname "$dst")" 
            fi
        else
            warn "Source file does not exist or is not a regular file" "$src"
        fi
    done
}
