
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-162 :

``` {.bash .numberLines}
echo "HARDE-RHEL-162 : S'assurer que les permissions sur /etc/cron.hourly soient correctes"
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
# Fin: HARDE-RHEL-162
```

