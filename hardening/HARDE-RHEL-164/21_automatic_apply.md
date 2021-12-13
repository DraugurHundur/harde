
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-164 :

``` {.bash .numberLines}
echo "HARDE-RHEL-164 : S'assurer que les permissions sur /etc/cron.weekly soient correctes"
chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
# Fin: HARDE-RHEL-164
```

