
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-045 :

``` {.bash .numberLines}
echo "HARDE-RHEL-45 : Désactiver le démon rhnsd"
systemctl --now disable rhnsd || true
# Fin: HARDE-RHEL-45
```

