#!/bin/bash

# For keeping my dotfile repo mostly in order (and not submoduled)
# 
# Uses `diff` and `stat` for comparisons.
# `diff` is used as like a bool return. Its normal output is
# redirected to /dev/null for now.
#
# TODO: Logging, maybe?
# TODO: Make it work with lists of files
#
# 1. Parse external inclusion list
# 2. Read paths and names into vars
# 3. Read from external config (probably hardcoded to start)
#   - target root dir
#   - target file names
# 4. Make funcs for path construction
# 5. ?
#
#
# thall.
# <thall@thallheim.com>


# VARIABLES

emacs_file_src="/home/thall/.emacs"
emacs_target_folder="/home/thall/dotfiles/emacs/"
emacs_target_filename=".emacs"
emacs_target_filepath="${emacs_target_folder}${emacs_target_filename}"

# MESSAGE STRINGS
copied_msg="[INFO] Source is newer. Target updated."
error_target_newer="[ERROR] Target file is newer: Exiting..."
warn_src_trgt_eq="[INFO] Nothing to do: Source and target have identical modification times."
diff_eq_msg="[INFO] Nothing to do: Files up to date."


# CHECK: source file exists
if [[ ! -e "$emacs_file_src" ]]; then
    printf '[ERROR] File not found: \\'%s\\'\n' "$emacs_file_src"
    exit 1
fi

# Create target folder and copy file immediately if they don't exist
if [[ ! -e "$emacs_target_folder" ]]; then
    mkdir -p '$emacs_target_folder'
    printf '[INFO] Created folder:  \\'%s\\'\n' "$emacs_target_folder"
fi
if [[ ! -e "$emacs_target_filepath" ]]; then
    cp "$emacs_file_src" "${emacs_target_filepath}"
    printf '%s\n' "$copied_msg"
    exit 0
fi

# CHECK: diff
if diff "$emacs_target_filepath" "$emacs_file_src" &>/dev/null; then
    printf '%s\n' "${diff_eq_msg}"
    exit 0
else
    ## CHECK: stat
    src_timestamp=$(stat -c %Y "$emacs_file_src")
    target_timestamp=$(stat -c %Y "$emacs_file_src_target")
    if [[ "$src_timestamp" -gt "$target_timestamp" ]]; then
	cp "$emacs_file_src" "$emacs_target_filepath"
	printf '%s\n' "$copied_msg"
    elif [[ "$src_timestamp" -lt "$target_timestamp" ]]; then
	printf '%s\n' "$error_target_newer"
	exit 1
# Should be unreachable, yes?
#    else
#	printf '%s\n' "$warn_src_trgt_eq"
    fi
fi

