### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-115:
```bash
if  ! grep -q -E '^Banner' /etc/ssh/sshd_config ; then echo "Banner /etc/issue.net">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-115
```
