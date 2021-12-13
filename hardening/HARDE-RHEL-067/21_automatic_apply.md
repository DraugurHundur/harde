
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-067 :

``` {.bash .numberLines}
echo "HARDE-RHEL-67 : S'assurer que le serveur Avahi est désactivé"
systemctl --now disable avahi-daemon || true
# Fin: HARDE-RHEL-67
```

