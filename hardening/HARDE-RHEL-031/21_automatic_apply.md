
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-031 :

``` {.bash .numberLines}
echo "HARDE-RHEL-31 : S'assurer que les paquets suspects soient loggués"
cat >/etc/sysctl.d/45logmartians.conf <<EOF
# Loguer les paquets ayant des IPs anormales
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
EOF
# Fin: HARDE-RHEL-31
```

