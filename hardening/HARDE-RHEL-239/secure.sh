echo "HARDE-RHEL-239 : S'assurer que journald compresse les journaux de grande taille"
cat > /etc/systemd/journald.conf.d/10-compress.conf <<EOF
[Journal]
Compress=yes
EOF
# Fin: HARDE-RHEL-239
