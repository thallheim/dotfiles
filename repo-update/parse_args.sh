#!/bin/bash

source "./functions.sh"

: ' FLAGS

Short	Long		Descr.
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
-h	--help		Show help.
-s	--status	Show time of last execution; List files that have since
			 changed.
-v	--verbose	Always print error summary; Always display absolute
			 paths.
 '

flag_verbose=false
flag_status=false
export flag_help=false

function parse_args() {
    while [ "$#" -gt 0 ]; do
	case "$1" in
	-v | --verbose)
	    flag_verbose=true
	    warn "TODO: Verbosity not implemented"
	    shift
	    ;;
	-t | --test)
	    get_src_paths
	    verify_src_paths
	    get_dst_dirs
	    mk_dst_dirs
	    copy_all
	    shift
	    ;;
	-d | --dirtest)
	    mk_dst_dirs
	    shift
	    ;;

	-h | --help)
	    flag_help=true
	    printf "H"
	    exit_done
	    ;;
	-s | --status)
	    flag_status=true
	    exit_fatal "TODO: Status not implemented"
	    ;;
	*)
	    exit_fatal "Invalid option: $1"
	    ;;
	esac

    done
}

