### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-118:
```bash
 if  ! grep -q -E '^MaxSessions' /etc/ssh/sshd_config ; then echo "MaxSessions 4">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-118
```
