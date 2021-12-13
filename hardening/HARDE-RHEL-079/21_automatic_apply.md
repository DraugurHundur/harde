
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-079 :

``` {.bash .numberLines}
echo "HARDE-RHEL-79 : Désactiver iptables"
systemctl --now mask iptables
# Fin: HARDE-RHEL-79
```

