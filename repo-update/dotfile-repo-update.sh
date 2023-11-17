#!/bin/bash

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
#       (Most) global vars and arrays
#
# "./inclusions.dat"
#	Newline-delimited list of files to be pulled into the dst dir
#
# "./info_errors.sh"
#	Strings, labels, functions for info and error handling
#      
# "./file-ops.sh"
#	File operations
#
# "./helpers.sh"
#	Helper functions
#
. "./parse_args.sh"
#	Contains the arg parser and related flags
#
. "./parse_settings.sh"
#       Parses user settings
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

parse_user_settings
parse_args "$@"
