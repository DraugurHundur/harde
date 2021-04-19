### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-113:
```bash
if  ! grep -q -E '^Client' /etc/ssh/sshd_config ; then echo -e "ClientAliveInterval 300\nClientAliveCountMax 0">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-113
```
