
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-115 :

``` {.bash .numberLines}
echo "HARDE-RHEL-115 : S'assurer que la bannière SSH est configurée"
if ! grep -q -E '^Banner' /etc/ssh/sshd_config; then echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-115
```

