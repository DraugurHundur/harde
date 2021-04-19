echo "HARDE-RHEL-35 : Activer les TCP Syn Cookies"
cat >/etc/sysctl.d/65syncookies.conf <<EOF
# Utiliser les SYN cookies
net.ipv4.tcp_syncookies = 1
EOF
# Fin: HARDE-RHEL-35
