
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-184 :

``` {.bash .numberLines}
echo "HARDE-RHEL-184 : S'assurer que les permissions sur /etc/gshadow- soient correctes"
chown root:root /etc/gshadow-
chmod o-rwx,g-rw /etc/gshadow-
# Fin: HARDE-RHEL-184
```

