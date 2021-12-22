
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-061 :

``` {.bash .numberLines}
echo "HARDE-RHEL-61 : S'assurer que le serveur LDAP est désactivé"
systemctl --now disable slapd || true
# Fin: HARDE-RHEL-61
```

