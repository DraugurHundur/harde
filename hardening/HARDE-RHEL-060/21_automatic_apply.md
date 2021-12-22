
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-060 :

``` {.bash .numberLines}
echo "HARDE-RHEL-60 : S'assurer que RPC est désactivé"
systemctl --now disable rpcbind || true
# Fin: HARDE-RHEL-60
```

