### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-094:
```bash
setsebool -P polyinstantiation_enabled=on
cat >/etc/secure_namespace.sh <<EOF
#! /bin/bash

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
```
