
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-116 :

``` {.bash .numberLines}
echo "HARDE-RHEL-116 : S'assurer que le paramètrage SSH PAM est activé"
if ! grep -q -E '^UsePAM' /etc/ssh/sshd_config; then echo "UsePAM yes" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-116
```

