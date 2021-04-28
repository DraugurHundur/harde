echo "HARDE-RHEL-90 : S'assurer que l'accès SSH soit limité"
if  ! grep -q -E '^AllowGroups sudogrp' /etc/ssh/sshd_config ; then echo "AllowGroups sudogrp" >> /etc/ssh/ssd_config ;fi 
if  ! grep -q -E '^DenyUsers root' /etc/ssh/sshd_config ; then echo "DenyUsers root" >> /etc/ssh/ssd_config; fi
# Fin: HARDE-RHEL-90
