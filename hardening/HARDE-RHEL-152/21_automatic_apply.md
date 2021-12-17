
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-152 :

``` {.bash .numberLines}
#! /bin/bash
echo "HARDE-RHEL-152 : Authentification des utilisateurs exécutant sudo"
if grep -q -E "^[^#].*NOPASSWD" /etc/sudoers; then
  echo "Directive NOPASSWD à supprimer du fichier /etc/sudoers"
fi
# Fin: HARDE-RHEL-152
```

