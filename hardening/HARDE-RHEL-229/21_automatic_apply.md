
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-229 :

``` {.bash .numberLines}
echo "HARDE-RHEL-229 : S'assurer que les événements modifiant les MAC soient collectéees"
cat >/etc/audit/rules.d/80MAC-policy.rules <<EOF
-w /etc/selinux/ -p wa -k MAC-policy
-w /usr/share/selinux/ -p wa -k MAC-policy
EOF
# Fin: HARDE-RHEL-229
```

