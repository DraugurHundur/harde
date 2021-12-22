
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-132 :

``` {.bash .numberLines}
#! /bin/bash
echo "HARDE-RHEL-132 : S'assurer que le verrouillage des comptes inutilisés soit de 30 jours ou moins"
useradd -D -f 30
# Fin: HARDE-RHEL-132
```

