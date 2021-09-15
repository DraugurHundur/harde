echo "HARDE-RHEL-238 : S'assurer que journald est redirigé vers rsyslog"
systemctl stop systemd-journald
systemctl disable systemd-journald
mkdir -p /etc/systemd/journald.conf.d/
cat >/etc/systemd/journald.conf.d/00-forwardsyslog.conf <<EOF
[Journal]
ForwardToSyslog=yes
EOF
# Fin: HARDE-RHEL-238
