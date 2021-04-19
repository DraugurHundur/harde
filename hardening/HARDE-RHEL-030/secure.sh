echo "HARDE-RHEL-30 : Refuser les paquets routés par la source"
cat >/etc/sysctl.d/40sourceroute.conf <<EOF
# Refuser les paquets de source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
EOF
# Fin: HARDE-RHEL-30
