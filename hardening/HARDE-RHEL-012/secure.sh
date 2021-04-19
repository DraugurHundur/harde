echo "HARDE-RHEL-12 : Partition séparée pour /home"
mount |grep -q -E '/home\s' || exit 3
# Fin: HARDE-RHEL-12
