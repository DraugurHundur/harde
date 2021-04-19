### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-121:
```bash
if  ! grep -q -E '^HostbasedAuthentication\s+no' /etc/ssh/sshd_config ; then echo "HostbasedAuthentication no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-121
```
