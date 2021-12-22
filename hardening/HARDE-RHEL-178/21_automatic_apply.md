
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-178 :

``` {.bash .numberLines}
echo "HARDE-RHEL-178 : S'assurer que les permissions sur /etc/shadow soient correctes"
chown root:root /etc/shadow
chmod o-rwx,g-wx /etc/shadow
# Fin: HARDE-RHEL-178
```

