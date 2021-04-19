### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-012:
```bash
mount |grep -q -E '/home\s' || exit 3
# Fin: HARDE-RHEL-12
```
