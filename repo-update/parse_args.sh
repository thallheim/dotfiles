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
flag_help=false


while [ "$#" -gt 0 ]; do
    case "$1" in
	-h | --help)
	    flag_help=true
	    printf "H"
	    exit_done
	    ;;
	-v | --verbose)
	    flag_verbose=true
	    printf "V"
	    exit_done
	    #shift
	    ;;
	-s | --status)
	    flag_status=true
	    printf "S\n"
	    exit_fatal "TODO: STATUS not implemented"
	    ;;
	*)
	    exit_fatal "Invalid option: $1"
	    ;;
    esac
    shift
done

