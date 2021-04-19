echo "HARDE-RHEL-113 : S'assurer que le paramètre SSH Idle Timeout Interval est configuré"
if  ! grep -q -E '^Client' /etc/ssh/sshd_config ; then echo -e "ClientAliveInterval 300\nClientAliveCountMax 0">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-113
