
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-226 :

``` {.bash .numberLines}
#! /bin/bash
# See https://workbench.cisecurity.org/tickets/13291
echo "HARDE-RHEL-226 : Auditer toute connexion/déconnexion"
cat >/etc/audit/rules.d/65audit.rules <<EOF
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
EOF
# Fin: HARDE-RHEL-226
```

