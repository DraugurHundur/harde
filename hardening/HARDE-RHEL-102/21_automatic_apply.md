
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-102 :

``` {.bash .numberLines}
echo "HARDE-RHEL-102 : S'assurer que le client NIS n'est pas installé"
dnf remove ypbind
# Fin: HARDE-RHEL-102
```

