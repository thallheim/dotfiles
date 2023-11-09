#!/bin/bash
# shellcheck disable=1091,2154

. "./functions.sh"


export flag_status=false

function parse_args() {
    while getopts "vuthsV" FLAG; do
	case "$FLAG" in
	v)
	    flag_verbose=true; printf "%s\n" "${flag_verbose}"; shift;;

	u)
	    get_src_paths
	    verify_src_readable
	    get_dst_dirs
	    mk_dst_dirs
	    copy_all;;

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
	    # TODO: Flesh out
	    printf "dotupdate %s\n\nWritten by thallheim.\n" "${version}"
	    exit 0;;

	*)
	    printf "${red_cross} ${error_label} %s\n" "Unknown option: $FLAG"
	    show_help	    
	    return 1;;
	esac

    done
}

