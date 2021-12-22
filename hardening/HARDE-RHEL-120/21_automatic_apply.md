
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-120 :

``` {.bash .numberLines}
echo "HARDE-RHEL-120 : S'assurer que le paramètre SSH IgnoreRhosts est activé"
if ! grep -q -E '^IgnoreRhosts\s+yes' /etc/ssh/sshd_config; then echo "IgnoreRhosts yes" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-120
```

