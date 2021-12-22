
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-050 :

``` {.bash .numberLines}
echo "HARDE-RHEL-50 : Activer le démon cron"
systemctl --now enable crond
# Fin: HARDE-RHEL-50
```

