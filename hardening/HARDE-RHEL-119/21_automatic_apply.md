
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-119 :

``` {.bash .numberLines}
echo "HARDE-RHEL-119 : S'assurer que le paramètre SSH MaxAuthTries est positionné à 4 ou moins"
echo "MaxAuthTries 4" >>/etc/ssh/sshd_config
# Fin: HARDE-RHEL-119
```

