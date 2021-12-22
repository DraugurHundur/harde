
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-177 :

``` {.bash .numberLines}
echo "HARDE-RHEL-177 : S'assurer que les permissions sur /etc/passwd soient correctes"
chown root:root /etc/passwd
chmod 644 /etc/passwd
# Fin: HARDE-RHEL-177
```

