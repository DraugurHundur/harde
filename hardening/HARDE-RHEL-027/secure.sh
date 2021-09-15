echo "HARDE-RHEL-27 : S'assurer que le mode FIPS ou FUTURE est activé pour le chiffrement"
update-crypto-policies --set FIPS
update-crypto-policies
# Fin: HARDE-RHEL-27
