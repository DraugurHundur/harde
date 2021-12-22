
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-068 :

``` {.bash .numberLines}
echo "HARDE-RHEL-68 : S'assurer que le serveur SNMP est désactivé"
systemctl --now disable snmpd || true
# Fin: HARDE-RHEL-68
```

