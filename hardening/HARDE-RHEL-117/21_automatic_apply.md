
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-117 :

``` {.bash .numberLines}
echo "HARDE-RHEL-117 : S'assurer que le paramètre SSH MaxStartups est configuré"
if ! grep -q -E '^MaxStartups' /etc/ssh/sshd_config; then echo "MaxStartups 10:30:60" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-117
```

