
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-029 :

``` {.bash .numberLines}
echo "HARDE-RHEL-29 : Désactiver les ICMP Redirects"
cat >/etc/sysctl.d/35icmpredirects.conf <<EOF
# Ne pas envoyer de redirections ICMP
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
# Ne pas accepter les ICMP de type redirect
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
EOF
# Fin: HARDE-RHEL-29
```

