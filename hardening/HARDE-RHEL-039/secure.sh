echo "HARDE-RHEL-39 : Paramétrage des sysctl réseau"
cat >/etc/sysctl.d/05anssi.conf <<EOF
# RFC 1337
net.ipv4.tcp_rfc1337 = 1
# Ignorer les réponses non conformes à la RFC 1122
net.ipv4.icmp_ignore_bogus_error_responses = 1
# Augmenter la plage pour les ports éphémères
net.ipv4.ip_local_port_range = 32768 65535
# Désactiver IPv6
net.ipv6.conf.all.disable_ipv6 = 1
EOF
# Fin: HARDE-RHEL-39
