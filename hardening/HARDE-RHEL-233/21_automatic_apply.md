
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-233 :

``` {.bash .numberLines}
echo "HARDE-RHEL-233 : Activer le service syslog"
systemctl --now enable rsyslog
# Fin: HARDE-RHEL-233
```

