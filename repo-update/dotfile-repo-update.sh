#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#       For keeping my dotfile repo mostly in order (and not submoduled)
#       
#       Uses `diff` and `stat` for comparisons.
#       `diff` is used as like a bool return. Its normal output is
#       redirected to /dev/null for now.
#      
#       TODO: Logging, maybe?
#       TODO: Make it work with lists of files
#      
#       1. Make funcs for path construction
#       2. ?
#      
#      
#       thall.
#       <thall@thallheim.com>

source "config"


read_paths
verify_paths
printf 'Woo!\n'



# CHECK: diff
#if diff "$emacs_target_filepath" "$emacs_file_src" &>/dev/null; then
#    printf '%s\n' "${diff_eq_msg}"
#    exit 0
#else
#    ## CHECK: stat
#    src_timestamp=$(stat -c %Y "$emacs_file_src")
#    target_timestamp=$(stat -c %Y "$emacs_file_src_target")
#    if [[ "$src_timestamp" -gt "$target_timestamp" ]]; then
#	cp "$emacs_file_src" "$emacs_target_filepath"
#	printf '%s\n' "$copied_msg"
#    elif [[ "$src_timestamp" -lt "$target_timestamp" ]]; then
#	printf '%s\n' "$error_target_newer"
#	exit 1
## Should be unreachable, yes?
##    else
##	printf '%s\n' "$warn_src_trgt_eq"
#    fi
#fi

