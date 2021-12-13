
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-207 :

``` {.bash .numberLines}
echo "HARDE-RHEL-207 : Partition séparée pour /var/log"
mount | grep -q -E '/var/log\s' || harde_error "/var/log n'est pas une partition séparée !"
# Fin: HARDE-RHEL-207
```

