
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-166 :

``` {.bash .numberLines}
echo "HARDE-RHEL-166 : S'assurer que les permissions sur /etc/cron.d soient correctes"
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
# Fin: HARDE-RHEL-166
```

