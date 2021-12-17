#!/bin/bash
umount /media
eject /dev/sr0

# restart SSHd
systemctl restart sshd
# rebuild initramfs
dracut --force
aide --init
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

popd || true >/dev/null
rm -rf "${WORKDIR}"

echo
echo "=== Fin de la sécurisation ==="
echo
echo "Merci de redémarrer le poste pour que l'ensemble des modifications soient prises en compte."

echo "Le poste va redémarrer ensuite une fois automatiquement, après le «relabeling» de SELinux."
echo " -> Merci de votre patience !"
# end-of-script
