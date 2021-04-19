### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-110:
```bash
sed -i -e 's/\(^PermitRootLogin yes\)/\#HARDE-RHEL-110: \1/' /etc/ssh/sshd_config
if  ! grep -q -E '^PermitRootLogin\s+no' /etc/ssh/sshd_config ; then echo "PermitRootLogin no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-110
```
