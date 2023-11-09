#!/bin/bash
# shellcheck disable=1091,2154,2059 # 'source-path=SCRIPTDIR' isn't working

function cd_own_dir(){ # In case it's run from somewhere other than its own dir
    local dir=""; dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    cd "$dir" || exit_fatal "DIR CHANGE FAILED"
}; cd_own_dir
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
# (!) The inclusion file needs to end with a blank line, or the last
# entry isn't read. TODO: Work out why
#
#
# FILE SUMMARIES:
#       
# "./globals.sh"
#
# "./colours_labels_strings.sh"
#
# "./inclusions.dat"
#	Newline-delimited list of files to be pulled into the dst dir
#
# "./info_errors.sh"
#	Strings, labels, functions for info and error handling
#      
# "./functions.sh"
#	File and directory handlers, as well as whatever didn't quite
#	merit factoring out.
#
# "./helpers.sh"
#	Helper functions
#
. "./parse_args.sh"
#	Contains the arg parser and related flags
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


parse_args "$@"
