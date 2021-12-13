
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-181 :

``` {.bash .numberLines}
echo "HARDE-RHEL-181 : S'assurer que les permissions sur /etc/passwd- soient correctes"
chown root:root /etc/passwd-
chmod u-x,go-rwx /etc/passwd-
# Fin: HARDE-RHEL-181
```

