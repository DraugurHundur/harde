### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-018:
```bash
mount |grep -q -E '/var/tmp\s' || exit 6
# Fin: HARDE-RHEL-18
```
