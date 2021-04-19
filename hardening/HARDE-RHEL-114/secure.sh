echo "HARDE-RHEL-114 : S'assurer que le paramètre SSH LoginGraceTime est positionné à une minute ou moins"
if  ! grep -q -E '^LoginGraceTime' /etc/ssh/sshd_config ; then echo "LoginGraceTime 60">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-114
