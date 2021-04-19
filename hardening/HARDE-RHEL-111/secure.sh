echo "HARDE-RHEL-111 : S'assurer que le paramètre SSH PermitEmptyPasswords est désactivé"
if  ! grep -q -E '^PermitEmptyPasswords\s+no' /etc/ssh/sshd_config ; then echo "PermitEmptyPasswords no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-111
