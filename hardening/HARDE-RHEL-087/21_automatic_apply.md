
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-087 :

``` {.bash .numberLines}
echo "HARDE-RHEL-87 : Activation de SELinux avec la politique targeted"
selinuxenabled || setenforce 1
fixfiles onboot
# Fin: HARDE-RHEL-87
```

