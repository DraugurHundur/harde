### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-105:
```bash
sed -i -e 's/\(^AllowTcpForwarding yes\)/\#HARDE-RHEL-105: \1/' /etc/ssh/sshd_config
if  ! grep -q -E '^AllowTcpForwarding' /etc/ssh/sshd_config ; then echo "AllowTcpForwarding no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-105
```
