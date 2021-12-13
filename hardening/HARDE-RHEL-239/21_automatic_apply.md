
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-239 :

``` {.bash .numberLines}
echo "HARDE-RHEL-239 : S'assurer que journald compresse les journaux de grande taille"
cat >/etc/systemd/journald.conf.d/10-compress.conf <<EOF
[Journal]
Compress=yes
EOF
# Fin: HARDE-RHEL-239
```

