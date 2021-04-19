### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-073:
```bash
for i in dccp sctp rds tipc; do
cat >"/etc/modprobe.d/$i.conf" <<EOF
install $i /bin/true
EOF
rmmod "$i" || true ; done
# Fin: HARDE-RHEL-73
```
