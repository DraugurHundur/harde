
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-103 :

``` {.bash .numberLines}
echo "HARDE-RHEL-103 : S'assurer que le client telnet n'est pas installé"
dnf remove telnet
# Fin: HARDE-RHEL-103
```

