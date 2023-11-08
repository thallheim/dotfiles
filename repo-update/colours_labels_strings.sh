#!/bin/bash
# shellcheck disable=2059,2155


# COLOURS
export reset=$(tput sgr0)
export black=$(tput setaf 0)

export bold=$(tput bold); export end_bold=$(tput sgr0)
export italic=$(tput sitm); export end_italic=$(tput ritm)

export darkblue=$(tput setaf 4); export blue=$(tput setaf 12)
export darkgrey=$(tput setaf 8); export grey=$(tput setaf 7)
export darkred=$(tput setaf 1); export red=$(tput setaf 9)
export darkgreen=$(tput setaf 2); export green=$(tput setaf 10)
export darkyellow=$(tput setaf 3); export yellow=$(tput setaf 11)
export darkmagenta=$(tput setaf 5); export magenta=$(tput setaf 13)
export darkcyan=$(tput setaf 6); export cyan=$(tput setaf 14)


# "ICONS"
export red_cross="$red""\xE2\x9D\x8C""$reset"
export green_checkmark="$green""\xE2\x9C\x93""$reset"
export info_arrow="$cyan""\xE2\x87\xA8""$reset"
export warn_triangle="\xE2\x9A\xA0"


# LABELS
export error_label="[$red""ERROR""$reset""] "
export info_label="[$cyan""INFO""$reset""] "
export warn_label="[$yellow""WARN""$reset""] "


# MSG STRINGS
export info_copied_msg="$info_label"" File updated: "
export error_target_newer="$error_label"" Target file is newer: Exiting..."
export info_src_trgt_eq="$info_label"" Nothing to do: Source and target have identical modification times."
export info_diff_eq_msg="$info_label"" Nothing to do: Files up to date."


# HELP/USAGE STRINGS
export usage="${blue}Usage:${reset}\n\t dotupdate.sh [OPTION]...\n\n\t (!)\tNote: ${darkgrey}Clustered short options ('-xyz') not yet supported; pass\n\t\tas '-x -y -z'${reset}\n\n"

export opts="${blue}Options:\n${reset}\tShort\tLong\t\tDescr.\n\t${darkgrey}¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨${reset}\n\t-h\t --help\t\tShow help.\n\t-s\t --status\tShow time of last execution; List files that have since changed.\n\t-v\t --verbose\tVerbose-mode; Always print error summary.\n\t\t --version\tShow version number.\n"
