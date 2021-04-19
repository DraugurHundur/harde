echo "HARDE-RHEL-97 : Confinement des utilisateurs interactifs non privilégiés"
# Find at least one user to add to sudogrp
USER1000="$(grep 1000 /etc/passwd | awk -F: '{print $1}')"
echo -n "Merci de préciser le nom d'un utilisateur à qui donner des droits administrateur [$USER1000] ? " ; read -e -i "$USER1000" -r ADMINUSER
if [ -z "${ADMINUSER}" ]; then
    ADMINUSER="${USER1000}"
fi
groupadd -r -f sudogrp
echo "%sudogrp    ALL=(ALL)  TYPE=unconfined_t ROLE=unconfined_r    ALL" >/etc/sudoers.d/15group
#usermod -Z sysadm_u "${ADMINUSER}"
semanage login -a -s staff_u -rs0:c0.c1023 "${ADMINUSER}" || true
usermod -G sudogrp "${ADMINUSER}"
# For unprivileged user, use usermod -Z user_u <unprivileged>
semanage login -m -r s0 -s user_u __default__
# restorecon is required at this point and will be performed on reboot
# Fin: HARDE-RHEL-97
