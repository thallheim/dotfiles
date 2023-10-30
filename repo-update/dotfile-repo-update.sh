#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
#       TODO: Proper description
#       For keeping my dotfile repo mostly in order (and not submoduled).
#       Also actually updated. 
#       
#      
#       TODO: Logging, maybe?
#      
#       1. Reimplement path checks
#       2. Reimplement age checks
#       3. Reimplement copy ops
#      
#      
#       thall.
#       <thall@thallheim.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

source "./functions.sh"
error_detected=0

inclusion_list_exists || error_detected=1
read_inc_list || error_detected=1
verify_src_paths || error_detected=1

if [ "$error_detected" -eq 0 ]; then
    echo "It wörks!"
else
    echo "It's bwoken."
fi


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

