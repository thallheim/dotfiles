#!/bin/bash
# shellcheck disable=1091,2154,2059 # 'shellcheck source-path=SCRIPTDIR' isn't working
true

function info() {
    if [ "$#" -gt 1 ]; then
	printf "$info_label %s: %s\n" "$1" "$2"
    elif [ "$#" -eq 1 ]; then
	printf "${info_arrow} ${info_label} %s\n" "$1"
    fi
}

function warn() {
    if [ "$#" -gt 1 ]; then
	printf "$warn_triangle $warn_label %s: %s\n" "$1" "$2"
    elif [ "$#" -eq 1 ]; then
	printf "$warn_triangle $warn_label %s\n" "$1"
    fi
}

function print_error_count() {
    local err_count="$((error_fatal + error_nonfatal))"

    printf "\nErrors total:\t%d""$err_count"
    printf "\n"
    printf " %s Fatal:\t%d\n" '-' "$error_fatal"
    printf " %s Non-fatal:\t%d\n" '-' "$error_nonfatal"
}

function exit_done() {
    printf "\n$info_arrow $info_label ${bold}Done. Exiting...\n${end_bold}"
    exit 0
}

function exit_nonfatal() {

    ((error_nonfatal++))
    printf "$warn_triangle $warn_label ${bold}Finished, but encountered non-fatal error(s):\n${end_bold}"
    printf "\t%s %s %s\n" "  -" "$1" "$2"

    # Check whether to display error counter
#    if [ "$arg1" = "-ec" ]; then
#	print_error_count
#    fi
    exit_done
}

function exit_fatal() {

    # Print error, increment error counter (and if it's been called)
    printf "$red_cross $error_label "
    printf "%s %s\n" "$1" "$2"
    ((error_fatal++))

#    if [ "$arg1" = "-ec" ]; then
#	print_error_count
#    fi
    exit 1
}
