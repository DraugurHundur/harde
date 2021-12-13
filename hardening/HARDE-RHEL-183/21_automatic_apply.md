
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-183 :

``` {.bash .numberLines}
echo "HARDE-RHEL-183 : S'assurer que les permissions sur /etc/group- soient correctes"
chown root:root /etc/group-
chmod u-x,go-wx /etc/group-
# Fin: HARDE-RHEL-183
```

