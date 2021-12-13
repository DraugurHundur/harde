
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-205 :

``` {.bash .numberLines}
#! /usr/bin/env bash
echo "HARDE-RHEL-205 : Désactivation du chargement des modules noyau"
cat >/etc/maintenance_mode.sh <<EOF
#! /bin/bash
[ $(getsebool secure_mode_insmod | awk '{print $3}') = "off" ]  && echo "Currently in maintenance mode"
if [ ! -f /SECURE_INSMOD_DISABLED ] ; then
    touch /SECURE_INSMOD_DISABLED
    echo "Maintenance mode will be enabled on next boot."
    echo "Run again to disable."
else
    rm /SECURE_INSMOD_DISABLED
    echo "Maintenance mode will *NOT* be enabled on next boot."
fi
EOF
chmod 0700 /etc/maintenance_mode.sh
cat >/etc/secure_insmod.sh <<EOF
#! /bin/bash
declare -a blacklist
blacklist=(
    [0]="usb-storage"
    [1]="cramfs"
    [2]="freevxfs"
    [3]="jffs2"
    [4]="hfs"
    [5]="hfsplus"
    [6]="squashfs"
    [7]="crc-itu-t"
    [8]="udf"
    [9]="fat"
    [10]="vfat"
)
if [ ! -f /SECURE_INSMOD_DISABLED ] ; then
    # Explicitely disable some modules
    for module in "\${blacklist[@]}"; do
        [ -e "/etc/modprobe.d/\$module.conf" ] || echo "install \$module /bin/true" >"/etc/modprobe.d/\$module.conf"
    done
    setsebool secure_mode_insmod on
    sysctl -w kernel.modules_disabled=1
    exit 0
else
    # Re-instate disabled modules
    for module in "\${blacklist[@]}"; do
        rm -f "/etc/modprobe.d/\$module.conf"
    done
    setsebool secure_mode_insmod off
    mount /boot
    mount /boot/efi
    modprobe iso9660
    echo "Secure insmod is DISABLED."
    rm -f /SECURE_INSMOD_DISABLED
fi
exit 0
EOF
chmod 0700 /etc/secure_insmod.sh
cat >/etc/systemd/system/secure_insmod.service <<EOF
[Unit]
Description=Script to prevents any further module loading
After=default.target

[Service]
Type=oneshot
ExecStart=/etc/secure_insmod.sh
ExecStop=/etc/secure_insmod.sh
TimeoutStartSec=0

[Install]
WantedBy=default.target
EOF
systemctl enable secure_insmod
# Fin: HARDE-RHEL-205
```

