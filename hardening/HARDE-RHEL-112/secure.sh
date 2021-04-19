echo "HARDE-RHEL-112 : S'assurer que le paramètre SSH PermitUserEnvironment est désactivé"
if  ! grep -q -E '^PermitUserEnvironment\s+no' /etc/ssh/sshd_config ; then echo "PermitUserEnvironment no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-112
