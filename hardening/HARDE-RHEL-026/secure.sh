echo "HARDE-RHEL-26 : S'assurer que les politiques de chiffrement historiques soit désactivées"
update-crypto-policies --set DEFAULT ; update-crypto-policies
# Fin: HARDE-RHEL-26
