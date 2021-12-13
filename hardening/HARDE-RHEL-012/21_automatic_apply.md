
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-012 :

``` {.bash .numberLines}
#! /bin/bash
echo "HARDE-RHEL-12 : Partition séparée pour /home"
mount | grep -q -E '/home\s' || harde_error "/home n'est pas une partition séparée !"
# Fin: HARDE-RHEL-12
```

