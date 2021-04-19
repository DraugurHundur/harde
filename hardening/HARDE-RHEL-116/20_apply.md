### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-116:
```bash
if  ! grep -q -E '^UsePAM' /etc/ssh/sshd_config ; then echo "UsePAM yes">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-116
```
