
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-028 :

``` {.bash .numberLines}
echo "HARDE-RHEL-28 : S'assurer que l'IP Forwarding est désactivé"
cat >/etc/sysctl.d/30forwarding.conf <<EOF
# Pas de routage entre les interfaces
net.ipv4.ip_forward = 0
EOF
# Fin: HARDE-RHEL-28
```

