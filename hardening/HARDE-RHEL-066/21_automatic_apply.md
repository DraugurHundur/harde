
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-066 :

``` {.bash .numberLines}
echo "HARDE-RHEL-66 : Désactiver le service rsyncd"
systemctl --now disable rsyncd || true
# Fin: HARDE-RHEL-66
```

