#!/bin/bash
# shellcheck disable=1091,2154

source "./functions.sh"

export flag_status=false

function parse_args() {
    while [ "$#" -gt 0 ]; do
	case "$1" in
	-v | --verbose)
	    flag_verbose=true
	    shift
	    ;;

	-u | --update)
	    get_src_paths
	    verify_src_readable
	    get_dst_dirs
	    mk_dst_dirs
	    copy_all
	    shift
	    ;;

	-t | --test)
	    echo "test :)"
	    exit_done
	    ;;

	-h | --help)
	    show_help
	    return 0
	    ;;

	-s | --status)
	    flag_status=true
	    exit_fatal "TODO: Status not implemented"
	    ;;

	*)
	    printf "${red_cross} ${error_label} %s\n" "Unknown option: $1"
	    show_help	    
	    return 1
	    ;;
	esac

    done
}

