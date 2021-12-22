
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-169 :

``` {.bash .numberLines}
echo "HARDE-RHEL-169 : S'assurer que les permissions sur les clés publiques d'hôte soient correctes"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chmod 0644 "{}" ";"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chown root:root "{}" ";"
# Fin: HARDE-RHEL-169
```

