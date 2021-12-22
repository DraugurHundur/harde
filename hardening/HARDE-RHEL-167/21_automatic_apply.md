
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-167 :

``` {.bash .numberLines}
echo "HARDE-RHEL-167 : S'assurer que les permissions sur /etc/ssh/sshd_config soient correctes"
chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config
# Fin: HARDE-RHEL-167
```

