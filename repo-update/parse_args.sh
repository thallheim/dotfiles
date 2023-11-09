#!/bin/bash


. "./functions.sh"

function parse_args() {
    while getopts ':vuthsV' flag; do
	case "$flag" in
	v)
	    FLAG_VERBOSE=true; printf "ARGS: %s\nVerbose mode: %s\n" "${flag}" "${FLAG_VERBOSE}";;

	u)
	    get_src_paths
	    verify_src_readable
	    get_dst_dirs
	    mk_dst_dirs
	    copy_all
	    ;;

	t)
	    echo "test :)"
	    exit_done;;

	h)
	    show_help
	    return 0;;

	s)
	    export FLAG_STATUS=true
	    exit_fatal "TODO: Status not implemented";;
	V)
	    printf "dotupdate %s\n\nLicense: MIT\nWritten by thallheim.\n" "${VERSION}"
	    exit 0;;

	*)
	    unknown="$OPTARG"
	    show_help
	    exit_fatal "Unknown option" "${unknown}"
	esac
    done
    shift
}

