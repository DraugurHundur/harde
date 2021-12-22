
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-080 :

``` {.bash .numberLines}
echo "HARDE-RHEL-80 : Désactiver nftables"
systemctl --now mask nftables
# Fin: HARDE-RHEL-80
```

