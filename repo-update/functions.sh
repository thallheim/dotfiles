#!/bin/bash

# GLOBALS & HELPER FUNCTIONS
# Colours/decoration/"icons"/labels/strings, usage/help, info, errors
. "./globals.sh"; . "./helpers.sh"; . "./info_errors.sh"


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# FUNCTIONS
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

# Verify the inclusion list exists and read it into input_paths()
function get_src_paths() {
    if [ -e "${INC_LIST}" ]; then
	while IFS= read -r line; do
	    INPUT_PATHS+=("$(eval echo "$line")")
	done < "$INC_LIST"
	# VERBOSE
	if [[ ${FLAG_VERBOSE} == true ]]; then
	   info_checkmark "Inclusion list OK" "${#INPUT_PATHS[@]} entries to validate"; fi
    else
	exit_fatal "Could not read inclusion list: " "${INC_LIST}"
    fi
}

# Verify src files are readable
function verify_src_readable() {
    info_circle "Verifying sources"
    for path in "${INPUT_PATHS[@]}"; do
	if [[ -r "${path}" ]]; then
	    INPUT_PATHS_VALIDATED+=("$path")
	    local path_stripped=""
	    path_stripped="$(shorten_slug "$path")"
	    # VERBOSE:
	    if [[ $FLAG_VERBOSE == true ]]; then
		info_checkmark "  Valid" "${path_stripped}"; fi
	else
	    local notfound=""
	    local result=""
	    notfound="$(shorten_slug "$path")"
	    result="${notfound/${HOME}/~}"
	    warn "Source file not found" "'${result}'"
	fi
	
	# Make sure at least one src file is readable, otherwise just exit
	# TODO: Implement the actual check
	if [[ ! "${#INPUT_PATHS_VALIDATED[@]}" -gt 0 ]]; then
	    ((error_fatal++))
	    exit_fatal "Failed to read sources. Check permissions if files are known good."; fi
    done
}

# Get folder structure from validated input paths
function get_dst_dirs() {
    info_circle "Validating source dir structures"

    for path in "${INPUT_PATHS_VALIDATED[@]}"; do
	#printf "RAW PATH: %s\n" "${path}"
	local file_stripped=""; local result=""
	file_stripped="$(dirname "$path")"

	# If it's not the home folder itself, process it
	if [[ ! "$file_stripped" = "${HOME}" ]]; then
	    result="$file_stripped"
	    
	    # Only add the path if it isn't already in the array
	    if ! [[ ${DST_DIRS_VALIDATED[*]} =~ ${result} ]]; then
		DST_DIRS_VALIDATED+=("$result")
		# VERBOSE
		if [[ $FLAG_VERBOSE == true ]]; then
		    info_checkmark "  Valid" "$(shorten_slug "${result}")"; fi
	    fi
	fi
    done
}

# TODO: Split dst path verification into new function so the test can run it without creating the folders
# Check if dst dirs exist and create as necessary
function mk_dst_dirs() {
    if [[ ! -d "${DST_ROOT}" ]]; then
	mkdir -p "${DST_ROOT}"
	info_circle "Created destination root directory"
    else
	info_checkmark "Destination root directory exists"
    fi
 
    # Create destination dirs
    info_circle "Creating destination directories"

    for path in "${DST_DIRS_VALIDATED[@]}"; do
	local dir=""
	dir="$(strip_home_slug "$path")"
	mkdir -p "${DST_ROOT}${dir}"
	# VERBOSE
	if [[ $FLAG_VERBOSE == true ]]; then
	    info_checkmark "  Created" "${DST_ROOT/${HOME}/\~}${dir}"; fi
    done
}

function copy_all() {
    # VERBOSE
    info_circle "Copying files"

    for src in "${INPUT_PATHS_VALIDATED[@]}"; do
        # Double-check src is a file before copying
	if [[ -f "$src" ]]; then
	    local dst=""
            dst="${DST_ROOT}$(strip_home_slug "$src")"
	    # Double-check dst is a dir before copying
            if [[ -d "$(dirname "$dst")" ]]; then
                cp "$src" "$dst"
                # VERBOSE
		if [[ $FLAG_VERBOSE == true ]]; then
		    info_copied "Copied" "$(shorten_slug "${src}")" "$(shorten_slug "${dst}")"
		fi
            else
		warn "Skipped file '%s': Destination directory doesn't exist (%s)" "$src" "$(dirname "$dst")" 
            fi
        else
            error_fatal "Source file does not exist or is not a regular file" "$src"
        fi
    done
}
