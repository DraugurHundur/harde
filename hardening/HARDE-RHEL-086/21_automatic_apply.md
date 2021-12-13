
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-086 :

``` {.bash .numberLines}
echo "HARDE-RHEL-86 : Désactiver les interfaces sans fil"
nmcli radio all off
# Fin: HARDE-RHEL-86
```

