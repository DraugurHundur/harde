echo "HARDE-RHEL-208 : Partition séparée pour /var/log/audit"
mount | grep -q -E '/var/log/audit\s' || harde_error "/var/log/audit n'est pas une partition séparée !"
# Fin: HARDE-RHEL-208
