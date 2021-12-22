
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-063 :

``` {.bash .numberLines}
echo "HARDE-RHEL-63 : S'assurer que le serveur CUPS est désactivé"
systemctl --now disable cups || true
# Fin: HARDE-RHEL-63
```

