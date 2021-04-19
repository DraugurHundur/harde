### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-114:
```bash
if  ! grep -q -E '^LoginGraceTime' /etc/ssh/sshd_config ; then echo "LoginGraceTime 60">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-114
```
