### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-152:
```bash
grep -q -E "^[^#].*NOPASSWD" /etc/sudoers  && echo "Directive NOPASSWD à supprimer du fichier /etc/sudoers"
# Fin: HARDE-RHEL-152
```
