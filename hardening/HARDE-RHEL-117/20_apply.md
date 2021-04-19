### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-117:
```bash
if  ! grep -q -E '^MaxStartups' /etc/ssh/sshd_config ; then echo "MaxStartups 10:30:60">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-117
```
