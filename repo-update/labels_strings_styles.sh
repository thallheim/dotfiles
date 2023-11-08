#!/bin/bash
# shellcheck disable=2059
source "./colours.sh"


# "Icons"
export red_cross="$red""\xE2\x9D\x8C""$reset"
export green_checkmark="$green""\xE2\x9C\x93""$reset"
export info_arrow="$cyan""\xE2\x87\xA8""$reset"
export warn_triangle="\xE2\x9A\xA0"


# Labels
export error_label="[$red""ERROR""$reset""] "
export info_label="[$cyan""INFO""$reset""] "
export warn_label="[$yellow""WARN""$reset""] "


# Msg strings
export info_copied_msg="$info_label"" File updated: "
export error_target_newer="$error_label"" Target file is newer: Exiting..."
export info_src_trgt_eq="$info_label"" Nothing to do: Source and target have identical modification times."
export info_diff_eq_msg="$info_label"" Nothing to do: Files up to date."


# Help/Usage strings
export usage="${green}Usage:${reset}\n\t dotupdate.sh [OPTION]\n\n\t (!)\tNote: Clustered short options ('-xyz') not yet supported; pass\n\t\tas '-x -y -z'\n\n"

export opts="\tShort\tLong\t\tDescr.\n\t¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨\n\t-h\t --help\t\tShow help.\n\t-s\t --status\tShow time of last execution; List files that have since changed.\n\t-v\t --verbose\tVerbose-mode; Always print error summary.\n\t\t --version\tShow version number.\n"
