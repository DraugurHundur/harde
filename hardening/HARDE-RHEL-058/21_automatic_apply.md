
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-058 :

``` {.bash .numberLines}
echo "HARDE-RHEL-58 : S'assurer que le serveur DNS est désactivé"
systemctl --now disable named || true
# Fin: HARDE-RHEL-58
```

