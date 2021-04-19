### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-243:
```bash
if  ! grep -q -E '^LogLevel\s+(VERBOSE|INFO)' /etc/ssh/sshd_config ; then echo "LogLevel VERBOSE">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-243
```
