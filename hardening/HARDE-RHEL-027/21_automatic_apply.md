
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-027 :

``` {.bash .numberLines}
#! /bin/bash
# FIXME should probably switch to FUTURE or something more secure
# See https://workbench.cisecurity.org/tickets/12887
echo "HARDE-RHEL-027 : S'assurer que le mode FIPS ou FUTURE est activé pour le chiffrement"
update-crypto-policies --set FIPS
update-crypto-policies
# Fin: HARDE-RHEL-027
```

