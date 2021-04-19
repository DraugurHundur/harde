### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-208:
```bash
mount | grep -q -E '/var/log/audit\s' || exit 8
# Fin: HARDE-RHEL-208
```
