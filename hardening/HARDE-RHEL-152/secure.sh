echo "HARDE-RHEL-152 : Authentification des utilisateurs exécutant sudo"
grep -q -E "^[^#].*NOPASSWD" /etc/sudoers  && echo "Directive NOPASSWD à supprimer du fichier /etc/sudoers"
# Fin: HARDE-RHEL-152
