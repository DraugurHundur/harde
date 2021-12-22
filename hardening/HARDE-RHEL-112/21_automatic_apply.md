
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-112 :

``` {.bash .numberLines}
echo "HARDE-RHEL-112 : S'assurer que le paramètre SSH PermitUserEnvironment est désactivé"
if ! grep -q -E '^PermitUserEnvironment\s+no' /etc/ssh/sshd_config; then echo "PermitUserEnvironment no" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-112
```

