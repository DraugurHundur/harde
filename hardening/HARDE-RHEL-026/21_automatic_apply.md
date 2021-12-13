
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-026 :

``` {.bash .numberLines}
#! /bin/bash
echo "HARDE-RHEL-026 : S'assurer que les politiques de chiffrement historiques soit désactivées"
update-crypto-policies --set DEFAULT
update-crypto-policies
# Fin: HARDE-RHEL-026
```

