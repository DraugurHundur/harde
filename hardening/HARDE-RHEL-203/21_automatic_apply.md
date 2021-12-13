
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-203 :

``` {.bash .numberLines}
echo "HARDE-RHEL-203 : Activer l'aléatoire dans l'organisation de l'espace d'adressage"
cat >/etc/sysctl.d/20aslr.conf <<EOF
# Activation de l'ASLR
kernel.randomize_va_space = 2
EOF
# Fin: HARDE-RHEL-203
```

