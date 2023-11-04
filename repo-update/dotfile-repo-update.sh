#!/bin/bash
# shellcheck disable=1091,2154,2059 # 'source-path=SCRIPTDIR' isn't working
true

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
#      
#       thall.						
#
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

source "./functions.sh"
source "./parse_args.sh"

# Get, and cd to, script's dir in case it's called from somewhere else
cd_own_dir

parse_args "$@"
read_inc_list
verify_src_paths
# TODO: Check and/or create dst dirs

# TODO: Copy the lot

# TODO: 
