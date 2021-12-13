
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-083 :

``` {.bash .numberLines}
echo "HARDE-RHEL-83 : Bloquer les services et ports inutiles"
firewall-cmd --remove-service=cockpit
firewall-cmd --runtime-to-permanent
# Fin: HARDE-RHEL-83
```

