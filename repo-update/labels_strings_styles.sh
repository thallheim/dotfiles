source "./colours.sh"



# "Icons"
red_cross="$red""\xE2\x9D\x8C""$reset"
green_checkmark="$green""\xE2\x9C\x93""$reset"
info_arrow="$cyan""\xE2\x87\xA8""$reset"
warn_triangle="\xE2\x9A\xA0"

# Labels
error_label="[$red""ERROR""$reset""] "
info_label="[$cyan""INFO""$reset""] "
warn_label="[$yellow""WARN""$reset""] "

# Msg strings
info_copied_msg="$info_label"" File updated: "
error_target_newer="$error_label"" Target file is newer: Exiting..."
info_src_trgt_eq="$info_label"" Nothing to do: Source and target have identical modification times."
info_diff_eq_msg="$info_label"" Nothing to do: Files up to date."
