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
