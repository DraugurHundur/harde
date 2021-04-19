echo "HARDE-RHEL-15 : S'assurer de la configuration de /tmp"
mount |grep -q -E '/tmp\s' || exit 4
# Fin: HARDE-RHEL-15
