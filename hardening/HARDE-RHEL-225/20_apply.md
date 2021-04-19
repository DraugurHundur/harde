### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-225:
```bash
cat >/etc/audit/rules.d/60scope.rules<<EOF
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
EOF
# Fin: HARDE-RHEL-225
```
