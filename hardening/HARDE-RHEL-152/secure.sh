#! /bin/bash
echo "HARDE-RHEL-152 : Authentification des utilisateurs exécutant sudo"
if grep -q -E "^[^#].*NOPASSWD" /etc/sudoers; then
  echo "Directive NOPASSWD à supprimer du fichier /etc/sudoers"
fi
# Fin: HARDE-RHEL-152
