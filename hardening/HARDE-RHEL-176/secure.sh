echo "HARDE-RHEL-176 : Auditer les exécutables SGID"
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 -ls >"$HOME/$0-sgid-$(date +'%Y-%m-%d').txt"
# Fin: HARDE-RHEL-176
