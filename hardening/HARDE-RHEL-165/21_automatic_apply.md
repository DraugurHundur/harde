
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-165 :

``` {.bash .numberLines}
echo "HARDE-RHEL-165 : S'assurer que les permissions sur /etc/cron.monthly soient correctes"
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
# Fin: HARDE-RHEL-165
```

