echo "HARDE-RHEL-209 : Journal spécifique pour sudo"
cat >/etc/sudoers.d/05log <<EOF
Defaults logfile="/var/log/sudo/sudo.log"
EOF
mkdir /var/log/sudo
semanage fcontext --add -t sudo_log_t /var/log/sudo
restorecon -R -v /var/log/sudo
# Fin: HARDE-RHEL-209
