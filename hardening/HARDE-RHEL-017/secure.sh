echo "HARDE-RHEL-17 : S'assurer de la configuration de /var"
mount |grep -q -E '/var\s' || exit 5
# Fin: HARDE-RHEL-17
