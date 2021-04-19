### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-112:
```bash
if  ! grep -q -E '^PermitUserEnvironment\s+no' /etc/ssh/sshd_config ; then echo "PermitUserEnvironment no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-112
```
