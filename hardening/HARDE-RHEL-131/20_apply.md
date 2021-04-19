### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-131:
```bash
if  ! grep -q -E '^PASS_WARN_AGE\s+14' /etc/login.defs ; then sed -e 's/\(PASS_WARN_AGE.*\)/# \1/' -i /etc/login.defs; echo "PASS_WARN_AGE 14" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-131
```
