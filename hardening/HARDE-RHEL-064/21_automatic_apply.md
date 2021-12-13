
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-064 :

``` {.bash .numberLines}
echo "HARDE-RHEL-64 : S'assurer que le serveur NIS est désactivé"
systemctl --now disable ypserv || true
# Fin: HARDE-RHEL-64
```

