#!/bin/bash
# shellcheck disable=2181

. "./functions.sh"
VALID_OPTS=""
VALID_OPTS=$( getopt -o :vuthsV --long verbose,update,test,help,status,version -- "$@" )

function parse_args() {
eval set -- "$VALID_OPTS"

    [ $? -eq 0 ] || {
        exit_fatal "No recognised option provided"
    }

while true; do
     case "$1" in
	 -v | --verbose)
	     FLAG_VERBOSE=true 
	     printf "${MAGENTA}Verbose mode:${RESET}\t%s\n \
${MAGENTA}ARGS:${RESET}\t\t%s\n" \
"${GREEN}${FLAG_VERBOSE}${RESET}" "${YELLOW}$*${RESET}"
	     shift;;
	    
	-u | --update)
	    get_src_paths
	    verify_src_readable
	    get_dst_dirs
	    mk_dst_dirs
	    copy_all
	    exit_done;;

	-t | --test)
	    echo "test :)"
	    exit_done;;

	-h | --help)
	    show_help
	    return 0;;
	    
	-s | --status)
	    export FLAG_STATUS=true
	    exit_nonfatal "TODO: Status not implemented";;

	-V | --version)
	    printf "dotupdate %s\n\nLicense: MIT\nWritten by thallheim.\n" "${VERSION}"
	    exit 0;;

	--)
	    show_help
	    shift
	    break;;
	esac
    done
}
