
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-179 :

``` {.bash .numberLines}
echo "HARDE-RHEL-179 : S'assurer que les permissions sur /etc/group soient correctes"
chown root:root /etc/group
chmod 644 /etc/group
# Fin: HARDE-RHEL-179
```

