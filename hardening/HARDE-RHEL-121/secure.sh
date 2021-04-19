echo "HARDE-RHEL-121 : S'assurer que le paramètre SSH HostbasedAuthentication est désactivé"
if  ! grep -q -E '^HostbasedAuthentication\s+no' /etc/ssh/sshd_config ; then echo "HostbasedAuthentication no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-121
