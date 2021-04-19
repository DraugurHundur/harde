### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-120:
```bash
if  ! grep -q -E '^IgnoreRhosts\s+yes' /etc/ssh/sshd_config ; then echo "IgnoreRhosts yes">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-120
```
