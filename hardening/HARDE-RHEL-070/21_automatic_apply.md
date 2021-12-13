
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-070 :

``` {.bash .numberLines}
echo "HARDE-RHEL-70 : S'assurer que le service Samba  est désactivé"
systemctl --now disable smb || true
# Fin: HARDE-RHEL-70
```

