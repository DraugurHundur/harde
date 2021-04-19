### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-130:
```bash
if  ! grep -q -E '^PASS_MIN_DAYS\s+365' /etc/login.defs ; then sed -e 's/\(PASS_MIN_DAYS.*\)/# \1/' -i /etc/login.defs; echo "PASS_MIN_DAYS 7" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-130
```
