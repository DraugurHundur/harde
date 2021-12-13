
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-163 :

``` {.bash .numberLines}
echo "HARDE-RHEL-163 : S'assurer que les permissions sur /etc/cron.daily soient correctes"
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
# Fin: HARDE-RHEL-163
```

