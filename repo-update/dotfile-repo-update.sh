#!/bin/bash

#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#
#       TODO: Proper description
#       For keeping my dotfile repo mostly in order (and not submoduled).
#       Also actually updated. 
#
#       (!) NOTE:
#       The inclusion file needs to end with a blank line, or the last entry
#       will not be read. TODO: Work out why.
#       
#      
#       TODO: Logging, maybe?
#      
#      
#      
#       thall.
#       <thall@thallheim.com>
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


# Get, and cd to, script's dir in case it's called from elsewhere
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"


source "./functions.sh"
# TODO: Remove: Debug only
#printf "ARGV[1] PASSED = \t%s\n\n" "$arg1"

source "./parse_args.sh"
parse_args
read_inc_list
verify_src_paths
