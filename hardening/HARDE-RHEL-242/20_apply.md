### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-242:
```bash
cat >/etc/logrotate.d/wtmp<<EOF
# no packages own wtmp -- we'll rotate it here
/var/log/wtmp {
    missingok
    monthly
    create 0600 root utmp
    minsize 1M
    rotate 12
}
EOF
cat >/etc/logrotate.d/lastlog<<EOF
# no packages own lastlog -- we'll rotate it here
/var/log/lastlog {
    missingok
    monthly
    create 0600 root utmp
    minsize 1M
    rotate 12
}
EOF
cat >/etc/logrotate.d/btmp<<EOF
# no packages own btmp -- we'll rotate it here
/var/log/btmp {
    missingok
    monthly
    create 0600 root utmp
    rotate 12
}
EOF
# Fin: HARDE-RHEL-242
```
