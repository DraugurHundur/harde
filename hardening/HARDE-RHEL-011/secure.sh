echo "HARDE-RHEL-11 : Désactiver les sytèmes de fichiers inutilisés"
for i in cramfs freevxfs jffs2 hfs hfsplus squashfs crc-itu-t udf fat vfat; do
  cat >"/etc/modprobe.d/$i".conf <<EOF
install $i /bin/true
EOF
  rmmod "$i" || true
done
# Fin: HARDE-RHEL-11
