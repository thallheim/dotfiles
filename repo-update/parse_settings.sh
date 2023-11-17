#!/bin/bash
# shellcheck disable=2034

declare -g settings_file="./settings.conf"
declare -x -A user_settings_array

function parse_user_settings() {
    while IFS='=' read -r key val; do
	user_settings_array["${key}"]=${val}
    done < <(awk -f ./get_overrides ${settings_file})

    if [[ ${user_settings_array["verbose_by_default"]} = "on" ]]; then
	#printf "%s\n" ${user_settings_array["verbose_by_default"]}
	FLAG_VERBOSE=true;
    fi
}

function get_override_states() {
    printf "Override states:\n"
    for key in "${!user_settings_array[@]}"; do
	printf "\t- %-20s =\t%s\n" "$key" "${user_settings_array[$key]}"
    done
}
