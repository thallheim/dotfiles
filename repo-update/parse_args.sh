#!/bin/bash
# shellcheck disable=2154

. "./functions.sh"

function parse_args() {
    while getopts "vuthsV" FLAG; do
	case "$FLAG" in
	v)
	    flag_verbose=true; printf "ARGS: %s\nVerbose mode: %s\n" "${FLAG}" "${flag_verbose}"
	    ;;

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
	    flag_status=true
	    exit_fatal "TODO: Status not implemented";;
	V)
	    printf "dotupdate %s\n\nLicense: MIT\nWritten by thallheim.\n" "${version}"
	    exit 0;;

	*)
	    printf "${red_cross} ${error_label} %s\n" "Unknown option: $FLAG"
	    show_help	    
	    return 1;;
	esac
    done
    shift
}

