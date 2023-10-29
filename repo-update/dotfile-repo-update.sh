#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#       For keeping my dotfile repo mostly in order (and not submoduled).
#       
#      
#       TODO: Logging, maybe?
#       TODO: Make it work with lists of files
#      
#       1. Make funcs for path construction
#       2. Reimplement file checks
#       3. 
#      
#      
#       thall.
#       <thall@thallheim.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

source "config"
error_detected=0

inclusion_list_exists || error_detected=1
read_inc_list || error_detected=1
verify_src_paths || error_detected=1

if [ "$error_detected" -eq 0 ]; then
    echo "It wörks!"
else
    echo "It's bwoken."
fi

# 1. Check src index exists
# 2. Check src paths valid
# 3. Create destination paths
# 4. Read inclusion file(s)
#   1. while read -r line; do into array
#   2. for-loop array, copying files
#   3. report
#   

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

