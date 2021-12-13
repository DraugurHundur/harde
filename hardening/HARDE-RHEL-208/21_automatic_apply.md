
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-208 :

``` {.bash .numberLines}
echo "HARDE-RHEL-208 : Partition séparée pour /var/log/audit"
mount | grep -q -E '/var/log/audit\s' || harde_error "/var/log/audit n'est pas une partition séparée !"
# Fin: HARDE-RHEL-208
```

