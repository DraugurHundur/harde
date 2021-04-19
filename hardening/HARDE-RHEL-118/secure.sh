echo "HARDE-RHEL-118 : S'assurer que le paramètre SSH MaxSessions est positionné à 4 ou moins"
 if  ! grep -q -E '^MaxSessions' /etc/ssh/sshd_config ; then echo "MaxSessions 4">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-118
