#!/bin/bash

# Global flags, vars, arrays, colour/decoration defs, help- & info strings,
# labels


# VARIABLES/ARRAYS
export version="0.0.1"
export input_paths=()
export input_paths_validated=()
export dst_dirs_validated=()
export inc_list="${HOME}/dotfiles/repo-update/inclusions.dat"
export dst_root="${HOME}/dotfiles/temp/"
# UNUSED: export dst_root_emacs="${HOME}/dotfiles/emacs/"

# FLAGS
export flag_verbose=false
export src_paths_ok=false
export flag_status=false


# COLOURS
# Decl.
export reset=; export black=; export bold=; export end_bold=; export italic=; export end_italic=; 
export darkblue=; export blue=; export darkgrey=; export grey=; export darkred=; export red=;
export darkgreen=; export green=; export darkyellow=; export yellow=; 
export darkmagenta=; export magenta=; export darkcyan=; export cyan=;

reset=$(tput sgr0)
black=$(tput setaf 0)

bold=$(tput bold); end_bold=$(tput sgr0)
italic=$(tput sitm); end_italic=$(tput ritm)

darkblue=$(tput setaf 4); blue=$(tput setaf 12)
darkgrey=$(tput setaf 8); grey=$(tput setaf 7)
darkred=$(tput setaf 1); red=$(tput setaf 9)
darkgreen=$(tput setaf 2); green=$(tput setaf 10)
darkyellow=$(tput setaf 3); yellow=$(tput setaf 11)
darkmagenta=$(tput setaf 5); magenta=$(tput setaf 13)
darkcyan=$(tput setaf 6); cyan=$(tput setaf 14)


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
