### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-111:
```bash
if  ! grep -q -E '^PermitEmptyPasswords\s+no' /etc/ssh/sshd_config ; then echo "PermitEmptyPasswords no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-111
```
