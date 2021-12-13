
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-091 :

``` {.bash .numberLines}
echo "HARDE-RHEL-91 : S'assurer que l'accès à la commande su est limité"
usermod -a -G wheel root
# Fin: HARDE-RHEL-91
```

