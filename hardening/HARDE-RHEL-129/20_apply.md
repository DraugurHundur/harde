### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-129:
```bash
if  ! grep -q -E '^PASS_MAX_DAYS\s+365' /etc/login.defs ; then sed -e 's/\(PASS_MAX_DAYS.*\)/# \1/' -i /etc/login.defs; echo "PASS_MAX_DAYS 365" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-129
```
