
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-040 :

``` {.bash .numberLines}
echo "HARDE-RHEL-40 : Permissions des fichiers de configuration du démarrage"
chown root:root /boot/grub2/grub*
chmod go-rwx /boot/grub2/grub*
# Fin: HARDE-RHEL-40
```

