#!/bin/bash

# Global variables and arrays for `dotupdate`
#

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
