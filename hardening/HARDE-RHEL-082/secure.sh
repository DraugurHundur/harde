echo "HARDE-RHEL-82 : S'assurer que les interfaces soient assignées à une zone"
ITF="$(nmcli --terse connection show | awk -F: '{print $1}')"
firewall-cmd --zone=public --change-interface="${ITF}"
# Fin: HARDE-RHEL-82
