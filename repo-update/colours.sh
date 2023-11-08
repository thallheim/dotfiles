#!/bin/bash
# shellcheck disable=2046,2154,2155

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
