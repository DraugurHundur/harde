
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-136 :

``` {.bash .numberLines}
echo "HARDE-RHEL-136 : S'assurer que le groupe par défaut du compte root est 0"
usermod -g 0 root
# Fin: HARDE-RHEL-136
```

