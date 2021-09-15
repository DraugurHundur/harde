echo "HARDE-RHEL-175 : Auditer les exécutables SUID"
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 -ls >"$HOME/$0-suid-$(date +'%Y-%m-%d').txt"
# Fin: HARDE-RHEL-175
