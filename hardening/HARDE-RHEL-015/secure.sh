echo "HARDE-RHEL-15 : S'assurer de la configuration de /tmp"
mount | grep -q -E '/tmp\s' || harde_error "/tmp n'est pas une partition séparée !"
# Fin: HARDE-RHEL-15
