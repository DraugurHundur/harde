
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-088 :

``` {.bash .numberLines}
echo "HARDE-RHEL-88 : Désinstallation des outils de débogage de politique SELinux"
dnf remove settroubleshoot mcstrans
# Fin: HARDE-RHEL-88
```

