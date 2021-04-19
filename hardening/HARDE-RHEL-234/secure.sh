echo "HARDE-RHEL-234 : Configurer les permissions des fichiers journaux"
cat > /etc/rsyslog.d/10FileCreate.conf <<EOF
\$FileCreateMode 0640
EOF
# Fin: HARDE-RHEL-234
