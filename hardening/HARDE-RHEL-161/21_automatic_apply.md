
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-161 :

``` {.bash .numberLines}
echo "HARDE-RHEL-161 : S'assurer que les permissions sur /etc/crontab soient correctes"
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
# Fin: HARDE-RHEL-161
```

