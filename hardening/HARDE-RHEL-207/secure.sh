echo "HARDE-RHEL-207 : Partition séparée pour /var/log"
mount | grep -q -E '/var/log\s' || echo "ERREUR: /var/log n'est pas une partition séparée !"
# Fin: HARDE-RHEL-207
