
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-220 :

``` {.bash .numberLines}
echo "HARDE-RHEL-220 : Tracer les actions des administrateurs"
cat >/etc/audit/rules.d/55actions.rules <<EOF
-w /var/log/sudo.log -p wa -k actions
EOF
# Fin: HARDE-RHEL-220
```

