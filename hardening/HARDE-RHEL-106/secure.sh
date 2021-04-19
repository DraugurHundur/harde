echo "HARDE-RHEL-106 : S'assurer que le transfert X11 SSH est désactivé"
sed -i -e 's/\(^X11Forwarding yes\)/\#HARDE-RHEL-106: \1/' /etc/ssh/sshd_config
if  ! grep -q -E '^X11Forwarding\s+no' /etc/ssh/sshd_config ; then echo "X11Forwarding no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-106
