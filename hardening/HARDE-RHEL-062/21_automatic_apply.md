
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-062 :

``` {.bash .numberLines}
echo "HARDE-RHEL-62 : S'assurer que le serveur DHCP est désactivé"
systemctl --now disable dhcpd || true
# Fin: HARDE-RHEL-62
```

