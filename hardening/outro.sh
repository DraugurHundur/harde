if [ ! "${YORN}" = "n" ]; then
    umount /mnt/disc 
    rmdir /mnt/disc
    eject /dev/sr0
fi

# restart SSHd 
systemctl restart sshd
aide --init
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

popd >/dev/null
rm -rf "${WORKDIR}"

echo "Fin de la sécurisation"
echo 
echo "Merci de redémarrer le poste pour que l'ensemble des modifications soient"
echo " prises en compte."
echo "Assurez-vous d'avoir modifié le fichier /etc/fstab selon le guide !"
echo "..."
echo "Le poste va redémarrer ensuite une fois automatiquement, après le «relabeling» de SELinux."
echo " ->Merci de votre patience !"
# end-of-script
