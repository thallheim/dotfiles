#!/bin/bash
# shellcheck disable=2112,2059,2154,3043,3060,3010,3011


# HELPERS

function show_help() {
cat << EOF
${BLUE}Usage:${RESET}
	dotupdate.sh [OPTION]...

${BLUE}Options:${RESET}
  (!) Note: ${DARKGREY}Verbosity flag must be passed first if desired.${RESET}

	  Short	    Long	Descr.
	  ${DARKGREY}¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨${RESET}
	  -h	    --help	Show help.
	  -v 	    --verbose	Run in verbose mode; always print error summary.
	  -s	    --status	Show time of last execution; List files that have since changed.
	  -V  	    --version	Show version number.

EOF
}

function strip_home_slug() {
    local input="$1"
    local slug_stripped="${input/${HOME}}"
    local result="${slug_stripped#\/}"
    printf "%s" "${result}"
}

function strip_slug() {
    local input="$1"; local result=""

    if [[ $input == ${HOME}"/" ]]; then
	local subst="~"
	sed -r "s#${HOME}#${subst}#" <<< "$input"; fi
}

function shorten_slug() {
    local input="$1"; local result=""

    if [[ $input == ${HOME}* ]]; then
	local subst="~"
	sed -r "s#${HOME}#${subst}#" <<< "$input"; fi
    
}
