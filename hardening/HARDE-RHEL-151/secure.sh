#! /bin/bash
echo "HARDE-RHEL-151 : Groupe dédié à l'usage de sudo"
#cat >/etc/sudoers.d/15group <<EOF
#%sudogrp ALL=(ALL) ALL
#EOF
groupadd -r -f sudogrp
chgrp sudogrp /usr/bin/sudo
chmod u+s /usr/bin/sudo
chmod o-rwx /usr/bin/sudo
# Fin: HARDE-RHEL-151
