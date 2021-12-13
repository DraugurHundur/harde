
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-038 :

``` {.bash .numberLines}
echo "HARDE-RHEL-38 : S'assurer que la politique de chiffrement système n'est pas outrepassée "
sed -E -i "s/^\s*(CRYPTO_POLICY\s*=.*)$/# \1/" /etc/sysconfig/sshd
systemctl reload sshd
# Fin: HARDE-RHEL-38
```

