#!/bin/bash
# shellcheck disable=1001,1091,2154,2059 # 'shellcheck source-path=SCRIPTDIR' isn't working
true

# GLOBALS
export version="0.0.1"
input_paths=()
input_paths_validated=()
dst_dirs_validated=()
inc_list="${HOME}/dotfiles/repo-update/inclusions.dat"
dst_root="${HOME}/dotfiles/temp/"
# UNUSED: dst_root_emacs="${HOME}/dotfiles/emacs/"

# FLAGS
src_paths_ok=false
export flag_verbose=false

# HELPERS
source "./helpers.sh"

# COLOURS
# Defined in `colours_labels_strings.sh`
# Defined: [black, red, green, yellow, blue, cyan (plus 'reset')]


# "ICONS" (UTF-8) & LABELS/MSG/HELP STRINGS
# [red_cross, green_checkmark, info_arrow]
# [error_label, info_label, warn_label]
# [info_copied_msg, error_target_newer, info_src_trgt_eq, info_diff_eq_msg]
source "./colours_labels_strings.sh"

# ERROR HANDLERS & FLAGS
source "./info_errors.sh"

# FUNCTIONS

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
	# VERBOSE
	if [[ $flag_verbose == true ]]; then
	   info_checkmark "Inclusion list OK" "${#input_paths[@]} entries to validate"; fi
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
	    # VERBOSE:
	    if [[ $flag_verbose == true ]]; then
		info_checkmark "  Valid" "${path_stripped}"; fi
	else
	    local notfound=""
	    local result=""
	    notfound="$(shorten_slug "$path")"
	    result="${notfound/${HOME}/~}"
	    warn "${bold}Source file not found${end_bold}" "'${result}'"
	fi
	
	# Make sure at least one src file is readable, otherwise just exit
	# TODO: Implement the actual check
	if [[ ! "${#input_paths_validated[@]}" -gt 0 ]]; then
	    src_paths_ok=false
	    exit_fatal "Failed to read sources. Check permissions if files are known good."; fi
    done
}

# Get folder structure from validated input paths
function get_dst_dirs() {
    info_arrow "Validating source dir structures"

    for path in "${input_paths_validated[@]}"; do
	#printf "RAW PATH: %s\n" "${path}"
	local file_stripped=""; local result=""
	file_stripped="$(dirname "$path")"

	# If it's not the home folder itself, process it
	if [[ ! "$file_stripped" = "${HOME}" ]]; then
	    result="$file_stripped"
	    
	    # Only add the path if it isn't already in the array
	    if ! [[ ${dst_dirs_validated[*]} =~ ${result} ]]; then
		dst_dirs_validated+=("$result")
		# VERBOSE
		if [[ $flag_verbose == true ]]; then
		    info_checkmark "  Valid" "$(shorten_slug "${result}")"; fi
	    fi
	fi
    done
}

# Check if dst dirs exist and create as necessary
function mk_dst_dirs() {
    if [[ ! -d "$dst_root" ]]; then
	mkdir -p "${dst_root}"
	info_arrow "Created destination root directory"
    else
	info_checkmark "Destination root directory exists"
    fi
 
    # Create destination dirs
    info_arrow "Creating destination directories"

    for path in "${dst_dirs_validated[@]}"; do
	local dir=""
	dir="$(strip_home_slug "$path")"
	mkdir -p "${dst_root}${dir}"
	# VERBOSE
	if [[ $flag_verbose == true ]]; then
	    info_checkmark "  Created" "${dst_root/${HOME}/\~}${dir}"; fi
    done
}

function copy_all() {
    # VERBOSE
    info_arrow "Copying files"

    for src in "${input_paths_validated[@]}"; do
        # Double-check src is a file before copying
	if [[ -f "$src" ]]; then
	    local dst=""
            dst="${dst_root}$(strip_home_slug "$src")"
	    # Double-check dst is a dir before copying
            if [[ -d "$(dirname "$dst")" ]]; then
                cp "$src" "$dst"
                # VERBOSE
		if [[ $flag_verbose == true ]]; then
		    printf "$green_checkmark $info_label""  %s ${cyan}->${reset} %s\n" "$(shorten_slug "${src}")" "$(shorten_slug "${dst}")"
		fi
            else
		warn "Skipped file '%s': Destination directory doesn't exist (%s)" "$src" "$(dirname "$dst")" 
            fi
        else
            error_fatal "Source file does not exist or is not a regular file" "$src"
        fi
    done
}
