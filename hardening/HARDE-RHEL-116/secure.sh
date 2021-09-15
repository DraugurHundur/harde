echo "HARDE-RHEL-116 : S'assurer que le paramètrage SSH PAM est activé"
if ! grep -q -E '^UsePAM' /etc/ssh/sshd_config; then echo "UsePAM yes" >>/etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-116
