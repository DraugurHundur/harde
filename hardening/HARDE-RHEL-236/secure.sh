echo "HARDE-RHEL-236 : Renvoyer les journaux vers un hôte distant"
# ask for the syslog server
echo -n "Merci de préciser l'adresse ou le nom du serveur SYSLOG distant :"
read -e -i '127.0.0.1' -r SYSLOGSERVER
cat >/etc/rsyslog.d/loghost.conf <<EOF
# TCP version *.*     @@$SYSLOGSERVER:514
*.*     @$SYSLOGSERVER:514
EOF
# Fin: HARDE-RHEL-236
