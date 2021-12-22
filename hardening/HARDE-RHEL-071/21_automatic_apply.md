
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-071 :

``` {.bash .numberLines}
echo "HARDE-RHEL-71 : S'assurer que le service IMAP/POP3 est désactivé"
systemctl --now disable dovecot || true
# Fin: HARDE-RHEL-71
```

