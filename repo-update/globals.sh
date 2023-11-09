#!/bin/bash

# Global flags, vars, arrays, colour/decoration defs, help- & info strings,
# labels


# VARIABLES/ARRAYS
export VERSION="0.0.1"
export INPUT_PATHS=()
export INPUT_PATHS_VALIDATED=()
export DST_DIRS_VALIDATED=()
export INC_LIST="${HOME}/dotfiles/repo-update/inclusions.dat"
export DST_ROOT="${HOME}/dotfiles/temp/"
# UNUSED: export DST_ROOT_EMACS="${HOME}/dotfiles/emacs/"

# FLAGS
export FLAG_VERBOSE=false
export SRC_PATHS_OK=false
export FLAG_STATUS=false


# COLOURS
# Decl.
export RESET=; export BLACK=; export BOLD=; export END_BOLD=; export ITALIC=; export END_ITALIC=; 
export DARKBLUE=; export BLUE=; export DARKGREY=; export GREY=; export DARKRED=; export RED=;
export DARKGREEN=; export GREEN=; export DARKYELLOW=; export YELLOW=; 
export DARKMAGENTA=; export MAGENTA=; export DARKCYAN=; export CYAN=;

RESET=$(tput sgr0)
BLACK=$(tput setaf 0)

BOLD=$(tput bold); END_BOLD=$(tput sgr0)
ITALIC=$(tput sitm); END_ITALIC=$(tput ritm)

DARKBLUE=$(tput setaf 4); BLUE=$(tput setaf 12)
DARKGREY=$(tput setaf 8); GREY=$(tput setaf 7)
DARKRED=$(tput setaf 1); RED=$(tput setaf 9)
DARKGREEN=$(tput setaf 2); GREEN=$(tput setaf 10)
DARKYELLOW=$(tput setaf 3); YELLOW=$(tput setaf 11)
DARKMAGENTA=$(tput setaf 5); MAGENTA=$(tput setaf 13)
DARKCYAN=$(tput setaf 6); CYAN=$(tput setaf 14)


# "ICONS"
export red_cross="$RED""\xE2\x9D\x8C""$RESET"
export green_checkmark="$GREEN""\xE2\x9C\x93""$RESET"
export info_arrow="$CYAN""\xE2\x87\xA8""$RESET"
export warn_triangle="\xE2\x9A\xA0"


# LABELS
export error_label="[$RED""ERROR""$RESET""] "
export info_label="[$CYAN""INFO""$RESET""] "
export warn_label="[$YELLOW""WARN""$RESET""] "


# MSG STRINGS
export error_target_newer="$error_label"" Target file is newer: Exiting..."
export info_src_trgt_eq="$info_label"" Nothing to do: Source and target have identical modification times."
export info_diff_eq_msg="$info_label"" Nothing to do: Files up to date."


# HELP/USAGE STRINGS
export USAGE="${BLUE}Usage:${RESET}\n\t dotupdate.sh [OPTION]...\n\n\t (!)\tNote: ${DARKGREY}Clustered short options ('-xyz') not yet supported; pass\n\t\tas '-x -y -z'${RESET}\n\n"

export OPTS="${BLUE}Options:\n${RESET}\tShort\tLong\t\tDescr.\n\t${DARKGREY}¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨${RESET}\n\t-h\t --help\t\tShow help.\n\t-s\t --status\tShow time of last execution; List files that have since changed.\n\t-v\t --verbose\tVerbose-mode; Always print error summary.\n\t\t --version\tShow version number.\n"
