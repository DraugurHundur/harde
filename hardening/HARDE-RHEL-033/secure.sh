echo "HARDE-RHEL-33 : Ignorer les réponses ICMP douteuses"
cat >/etc/sysctl.d/55icmpbogus.conf <<EOF
# Refuser les réponses ICMP bogus
net.ipv4.icmp_ignore_bogus_error_responses = 1
EOF
# Fin: HARDE-RHEL-33
