
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-072 :

``` {.bash .numberLines}
echo "HARDE-RHEL-72 : S'assurer que le serveur HTTP est désactivé"
systemctl --now disable httpd || true
# Fin: HARDE-RHEL-72
```

