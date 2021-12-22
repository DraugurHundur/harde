
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-032 :

``` {.bash .numberLines}
echo "HARDE-RHEL-32 : Refuser les ICMP broadcast"
cat >/etc/sysctl.d/50icmpbroadcast.conf <<EOF
# Refuser les requêtes ICMP vers une adresse de broadcast/multicast
net.ipv4.icmp_echo_ignore_broadcasts = 1
EOF
# Fin: HARDE-RHEL-32
```

