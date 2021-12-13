
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-243 :

``` {.bash .numberLines}
echo "HARDE-RHEL-243 : S'assurer que le paramètre SSH LogLevel est approprié"
if ! grep -q -E '^LogLevel\s+(VERBOSE|INFO)' /etc/ssh/sshd_config; then echo "LogLevel VERBOSE" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-243
```

