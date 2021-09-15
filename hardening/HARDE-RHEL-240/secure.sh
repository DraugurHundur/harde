echo "HARDE-RHEL-240 : S'assurer que journald écrit les journaux sur disque"
cat >/etc/systemd/journald.conf.d/20-persistent.conf <<EOF
[Journal]
Storage=persistent
EOF
# Fin: HARDE-RHEL-240
