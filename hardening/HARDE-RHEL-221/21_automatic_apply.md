
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-221 :

``` {.bash .numberLines}
echo "HARDE-RHEL-221 : S'assurer que la configuration auditd n'est pas modifiable"
cat >/etc/audit/rules.d/zz_lock.rules <<EOF
# Verrouillage de la configuration de auditd
-e 2
EOF
# Fin: HARDE-RHEL-221
```

