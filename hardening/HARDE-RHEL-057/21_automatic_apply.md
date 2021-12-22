
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-057 :

``` {.bash .numberLines}
echo "HARDE-RHEL-57 : S'assurer que le serveur FTP est désactivé"
systemctl --now disable vsftpd || true
# Fin: HARDE-RHEL-57
```

