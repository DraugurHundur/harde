
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-111 :

``` {.bash .numberLines}
echo "HARDE-RHEL-111 : S'assurer que le paramètre SSH PermitEmptyPasswords est désactivé"
if ! grep -q -E '^PermitEmptyPasswords\s+no' /etc/ssh/sshd_config; then echo "PermitEmptyPasswords no" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-111
```

