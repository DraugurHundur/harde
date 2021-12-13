
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-034 :

``` {.bash .numberLines}
echo "HARDE-RHEL-34 : Activer le filtrage par routage inversé"
cat >/etc/sysctl.d/60rp_filter.conf <<EOF
# Filtrage par chemin inverse
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
EOF
# Fin: HARDE-RHEL-34
```

