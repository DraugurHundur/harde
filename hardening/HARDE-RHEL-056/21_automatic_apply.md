
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-056 :

``` {.bash .numberLines}
echo "HARDE-RHEL-56 : Ne pas installer xinetd"
dnf remove xinetd || true
# Fin: HARDE-RHEL-56
```

