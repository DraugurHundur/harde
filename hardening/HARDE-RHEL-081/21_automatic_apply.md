
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-081 :

``` {.bash .numberLines}
echo "HARDE-RHEL-81 : S'assurer qu'une zone par défaut est définie"
firewall-cmd --set-default-zone=public
# Fin: HARDE-RHEL-81
```

