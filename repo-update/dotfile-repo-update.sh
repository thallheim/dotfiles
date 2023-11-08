#!/bin/bash
# shellcheck disable=1091,2154,2059 # 'source-path=SCRIPTDIR' isn't working


#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
# (!) The inclusion file needs to end with a blank line, or the last
# entry isn't read. TODO: Work out why
#
#
# FILE SUMMARIES:
#       
# - INCLUSIONS.DAT
#	Newline-delimited list of files to be pulled into the dst dir
#
# - INFO_ERRORS.SH
#	Strings, labels, functions for info and error handling
#      
# - FUNCTIONS.SH
#	File and directory handlers, as well as whatever didn't quite
#	merit factoring out.
#
# - HELPERS.SH
#	Helper functions
#
# - PARSE_ARGS.SH
#	Contains the arg parser and related flags
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


function cd_own_dir(){
    local dir=""; dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd "$dir" || exit_fatal "DIR CHANGE FAILED"
}; cd_own_dir

source "./functions.sh"
source "./parse_args.sh"

parse_args "$@"


# TODO: Check and/or create dst dirs

# TODO: Copy the lot

# TODO: 
