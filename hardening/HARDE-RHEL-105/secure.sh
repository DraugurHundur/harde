echo "HARDE-RHEL-105 : S'assurer que le paramètre SSH AllowTcpForwarding est désactivé"
sed -i -e 's/\(^AllowTcpForwarding yes\)/\#HARDE-RHEL-105: \1/' /etc/ssh/sshd_config
if ! grep -q -E '^AllowTcpForwarding' /etc/ssh/sshd_config; then echo "AllowTcpForwarding no" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-105
