echo "HARDE-RHEL-207 : Partition séparée pour /var/log"
mount | grep -q -E '/var/log\s' || harde_error "/var/log n'est pas une partition séparée !"
# Fin: HARDE-RHEL-207
