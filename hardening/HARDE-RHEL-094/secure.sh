echo "HARDE-RHEL-94 : Répertoires temporaires dédiés aux comptes"
setsebool -P polyinstantiation_enabled=on
cat >/etc/secure_namespace.sh <<EOF
#! /bin/bash

function copy_se_labels() {
    # copy SElinux labels from $1 to $2
    # use copy_se_labels /var/www /srv/www(/.*)?
    semanage fcontext --modify --equal "$1" "$2" || true
    restorecon -R "$2"
}
# As /tmp is cleaned at each reboot, recreate them as needed
if ! [ -d /tmp/namespace ] ; then
    mkdir /tmp/namespace 
fi 
if ! [ -d /var/tmp/namespace ] ; then
    mkdir /var/tmp/namespace
fi
chmod 000 /tmp/namespace
#chcon --reference=/tmp /tmp/namespace
copy_se_labels /tmp /tmp/namespace
chmod 000 /var/tmp/namespace 
#chcon --reference=/var/tmp /var/tmp/namespace
copy_se_labels /var/tmp /var/tmp/namespace
EOF
chmod 0700 /etc/secure_namespace.sh
cat >/etc/systemd/system/secure_namespace.service<<EOF
[Unit]
Description=Script to create the required directories for pam_namespace

[Service]
Type=oneshot
ExecStart=/etc/secure_namespace.sh
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF
systemctl enable secure_namespace
cat >/etc/security/namespace.d/10tmp.conf <<EOF
/tmp     /tmp/namespace/        level      root
/var/tmp /var/tmp/namespace/    level      root
EOF
# Fin: HARDE-RHEL-94
