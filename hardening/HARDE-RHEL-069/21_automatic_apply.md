
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-069 :

``` {.bash .numberLines}
echo "HARDE-RHEL-69 : S'assurer que le service Proxy HTTP est désactivé"
systemctl --now disable squid || true
# Fin: HARDE-RHEL-69
```

