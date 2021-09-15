echo "HARDE-RHEL-110 : S'assurer que le paramètre SSH root login est désactivé"
sed -i -e 's/\(^PermitRootLogin yes\)/\#HARDE-RHEL-110: \1/' /etc/ssh/sshd_config
if ! grep -q -E '^PermitRootLogin\s+no' /etc/ssh/sshd_config; then echo "PermitRootLogin no" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-110
