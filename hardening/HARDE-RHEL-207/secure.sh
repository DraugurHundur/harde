echo "HARDE-RHEL-207 : Partition séparée pour /var/log"
mount | grep -q -E '/var/log\s' || exit 7
# Fin: HARDE-RHEL-207
