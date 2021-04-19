echo "HARDE-RHEL-18 : S'assurer de la configuration de /var/tmp"
mount |grep -q -E '/var/tmp\s' || exit 6
# Fin: HARDE-RHEL-18
