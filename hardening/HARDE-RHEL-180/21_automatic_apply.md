
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-180 :

``` {.bash .numberLines}
echo "HARDE-RHEL-180 : S'assurer que les permissions sur /etc/gshadow soient correctes"
chown root:root /etc/gshadow
chmod o-rwx,g-rw /etc/gshadow
# Fin: HARDE-RHEL-180
```

