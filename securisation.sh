#! /usr/bin/env bash
# -*- mode: shell; coding: utf-8-unix -*-

[ -d /boot/grub2 ] || ( echo "La partition /boot doit être accessible." ; exit 127 )

# source cdir.sh
pushd . >/dev/null
#WORKDIR="$(mktemp -d --tmpdir)"
WORKDIR=$(mktemp -t .hardening-run.XXXXXXXXXX -p "$HOME" -d)
# cd "$WORKDIR"
SCRIPTNAME="$(basename "$0")"
OUTFILE="/$HOME/$SCRIPTNAME-$$.txt"
# Exit on error
set -e
exec > >(tee "${OUTFILE}") 2>&1

function copy_se_labels() {
    # copy SElinux labels from $1 to $2
    # use copy_se_labels /var/www /srv/www(/.*)?
    semanage fcontext --modify --equal "$1" "$2" || true
    restorecon -R "$2"
}

# To use the DVD, if available
if [ ! -e /mnt/disc/media.repo ]; then
    echo -n "Est-ce que le DVD d'installation est dans le lecteur ? " ; read -e -i "O" -r YORN
    if [ ! "${YORN}" = "n" ]; then 
	mkdir -p /mnt/disc
	mount -o ro /dev/sr0 /mnt/disc
	cat >/etc/yum.repos.d/rhel8.1dvd.repo <<EOF
[InstallMedia-BaseOS]			      
name=Red Hat Enterprise Linux 8 - BaseOS
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///mnt/disc/BaseOS/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

[InstallMedia-AppStream]
name=Red Hat Enterprise Linux 8 - AppStream
metadata_expire=-1
gpgcheck=1
enabled=1
baseurl=file:///mnt/disc/AppStream/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release
EOF
    fi	
fi
if [ ! -e /mnt/disc/media.repo ]; then
    echo "Le disque d'installation est requis pour l'exécution de ce script."
    exit 1
fi

echo "HARDE-RHEL-1 : Minimisation des services installés"
# If we're online update
dnf update
# packages that we depends on
dnf install --assumeyes net-tools tar policycoreutils-python-utils setools-console chrony rsyslog bzip2 firewalld audit usbguard rng-tools openscap-scanner libcap-ng-utils aide rsyslog rsyslog-gnutls audispd-plugins tmux dnf-automatic sssd-ipa sudo policycoreutils python3-subscription-manager-rhsm fapolicyd aide scap-security-guide sssd realmd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools krb5-workstation openldap-clients python3-policycoreutils
dnf remove --assumeyes abrt-addon-ccpp abrt-plugin-sosreport iprutils nfs-utils abrt-addon-python tuned abrt-addon-kerneloops gssproxy abrt-plugin-logger abrt-cli abrt-plugin-rhtsupport sendmail abrt setroubleshoot setroubleshoot-server mcstrans xinetd xorg-x11* ypbind telnet
# Fin: HARDE-RHEL-1
echo "HARDE-RHEL-2 : Minimisation de la configuration"

# Fin: HARDE-RHEL-2
echo "HARDE-RHEL-3 : Principe de moindre privilège"

# Fin: HARDE-RHEL-3
echo "HARDE-RHEL-4 : Utilisation des fonctions de contrôles d'accès"

# Fin: HARDE-RHEL-4
echo "HARDE-RHEL-5 : Principe de défense en profondeur"

# Fin: HARDE-RHEL-5
echo "HARDE-RHEL-6 : Cloisonnement des services réseaux"

# Fin: HARDE-RHEL-6
echo "HARDE-RHEL-7 : Journalisation de l'activité des services"

# Fin: HARDE-RHEL-7
echo "HARDE-RHEL-8 : Mises à jour régulières"

# Fin: HARDE-RHEL-8
echo "HARDE-RHEL-9 : Configuration matérielle"

# Fin: HARDE-RHEL-9
echo "HARDE-RHEL-10 : Architecture 32 et 64 bits"

# Fin: HARDE-RHEL-10
echo "HARDE-RHEL-11 : Désactiver les sytèmes de fichiers inutilisés"
for i in cramfs freevxfs jffs2 hfs hfsplus squashfs crc-itu-t udf fat vfat; do
cat >"/etc/modprobe.d/$i".conf <<EOF
install $i /bin/true
EOF
rmmod "$i" || true ; done
# Fin: HARDE-RHEL-11
echo "HARDE-RHEL-12 : Partition séparée pour /home"
mount |grep -q -E '/home\s' || exit 3
# Fin: HARDE-RHEL-12
echo "HARDE-RHEL-13 : Options de montage nodev,nosuid,noexec pour /dev/shm"

# Fin: HARDE-RHEL-13
echo "HARDE-RHEL-14 : Options de montage nodev,nosuid,noexec pour les points de montage temporaire"

# Fin: HARDE-RHEL-14
echo "HARDE-RHEL-15 : S'assurer de la configuration de /tmp"
mount |grep -q -E '/tmp\s' || exit 4
# Fin: HARDE-RHEL-15
echo "HARDE-RHEL-16 : Désactiver le stockage USB"
declare -a modules
modules=(
    [0]="usb-storage"
)
for i in "${modules[@]}"; do
    cat >"/etc/modprobe.d/$i.conf" <<EOF
install $i /bin/true
EOF
    rmmod "$i" || true
done
# Fin: HARDE-RHEL-16
echo "HARDE-RHEL-17 : S'assurer de la configuration de /var"
mount | grep -q -E '/var\s' || exit 5
# Fin: HARDE-RHEL-17
echo "HARDE-RHEL-18 : S'assurer de la configuration de /var/tmp"
mount | grep -q -E '/var/tmp\s' || exit 6
# Fin: HARDE-RHEL-18
echo "HARDE-RHEL-19 : Partitionnement type"

# Fin: HARDE-RHEL-19
echo "HARDE-RHEL-20 : Restrictions d'accès sur le dossier /boot"

# Fin: HARDE-RHEL-20
echo "HARDE-RHEL-21 : Installation de paquets réduite au strict nécessaire"

# Fin: HARDE-RHEL-21
echo "HARDE-RHEL-22 : Choix des dépôts de paquets"

# Fin: HARDE-RHEL-22
echo "HARDE-RHEL-23 : Dépôts de paquets durcis"

# Fin: HARDE-RHEL-23
echo "HARDE-RHEL-24 : Robustesse du mot de passe administrateur"

# Fin: HARDE-RHEL-24
echo "HARDE-RHEL-25 : Installation d'éléments secrets ou de confiance"

# Fin: HARDE-RHEL-25
echo "HARDE-RHEL-26 : S'assurer que les politiques de chiffrement historiques soit désactivées"
update-crypto-policies --set DEFAULT ; update-crypto-policies
# Fin: HARDE-RHEL-26
echo "HARDE-RHEL-27 : S'assurer que le mode FIPS ou FUTURE est activé pour le chiffrement"
update-crypto-policies --set FIPS; update-crypto-policies
# Fin: HARDE-RHEL-27
echo "HARDE-RHEL-28 : S'assurer que l'IP Forwarding est désactivé"
cat >/etc/sysctl.d/30forwarding.conf <<EOF
# Pas de routage entre les interfaces
net.ipv4.ip_forward = 0
EOF
# Fin: HARDE-RHEL-28
echo "HARDE-RHEL-29 : Désactiver les ICMP Redirects"
cat >/etc/sysctl.d/35icmpredirects.conf <<EOF
# Ne pas envoyer de redirections ICMP
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
# Ne pas accepter les ICMP de type redirect
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
EOF
# Fin: HARDE-RHEL-29
echo "HARDE-RHEL-30 : Refuser les paquets routés par la source"
cat >/etc/sysctl.d/40sourceroute.conf <<EOF
# Refuser les paquets de source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
EOF
# Fin: HARDE-RHEL-30
echo "HARDE-RHEL-31 : S'assurer que les paquets suspects soient loggués"
cat >/etc/sysctl.d/45logmartians.conf <<EOF
# Loguer les paquets ayant des IPs anormales
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
EOF
# Fin: HARDE-RHEL-31
echo "HARDE-RHEL-32 : Refuser les ICMP broadcast"
cat >/etc/sysctl.d/50icmpbroadcast.conf <<EOF
# Refuser les requêtes ICMP vers une adresse de broadcast/multicast
net.ipv4.icmp_echo_ignore_broadcasts = 1
EOF
# Fin: HARDE-RHEL-32
echo "HARDE-RHEL-33 : Ignorer les réponses ICMP douteuses"
cat >/etc/sysctl.d/55icmpbogus.conf <<EOF
# Refuser les réponses ICMP bogus
net.ipv4.icmp_ignore_bogus_error_responses = 1
EOF
# Fin: HARDE-RHEL-33
echo "HARDE-RHEL-34 : Activer le filtrage par routage inversé"
cat >/etc/sysctl.d/60rp_filter.conf <<EOF
# Filtrage par chemin inverse
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
EOF
# Fin: HARDE-RHEL-34
echo "HARDE-RHEL-35 : Activer les TCP Syn Cookies"
cat >/etc/sysctl.d/65syncookies.conf <<EOF
# Utiliser les SYN cookies
net.ipv4.tcp_syncookies = 1
EOF
# Fin: HARDE-RHEL-35
echo "HARDE-RHEL-36 : Refuser les paquets IPv6 Router Advertisements"

# Fin: HARDE-RHEL-36
echo "HARDE-RHEL-37 : Désactiver IPV6"
if ! grep -q -E 'ipv6.disable=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 ipv6.disable=1"/' -i /etc/default/grub ; echo "Parameter ipv6.disable added."; fi
grub2-mkconfig –o /boot/grub2/grub.cfg  >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-37
echo "HARDE-RHEL-38 : S'assurer que la politique de chiffrement système n'est pas outrepassée "
sed -E -i "s/^\s*(CRYPTO_POLICY\s*=.*)$/# \1/" /etc/sysconfig/sshd
systemctl reload sshd
# Fin: HARDE-RHEL-38
echo "HARDE-RHEL-39 : Paramétrage des sysctl réseau"
cat >/etc/sysctl.d/05anssi.conf <<EOF
# RFC 1337
net.ipv4.tcp_rfc1337 = 1
# Ignorer les réponses non conformes à la RFC 1122
net.ipv4.icmp_ignore_bogus_error_responses = 1
# Augmenter la plage pour les ports éphémères
net.ipv4.ip_local_port_range = 32768 65535
# Désactiver IPv6
net.ipv6.conf.all.disable_ipv6 = 1
EOF
# Fin: HARDE-RHEL-39
echo "HARDE-RHEL-40 : Permissions des fichiers de configuration du démarrage"
chown root:root /boot/grub2/grub*
chmod go-rwx /boot/grub2/grub*
# Fin: HARDE-RHEL-40
echo "HARDE-RHEL-41 : Verrouiller par mot de passe la configuration de demarrage"
while ! grub2-setpassword -o /boot/grub2; do
    echo "Mot de passe non enregistré. Veuillez réessayer ..."
done
cp /boot/grub2/user.cfg /boot/efi/EFI/redhat/
# Fin: HARDE-RHEL-41
echo "HARDE-RHEL-42 : Demander un mot de passe pour les modes de secours"

# Fin: HARDE-RHEL-42
echo "HARDE-RHEL-43 : Directive de configuration de l'IOMMU"
if ! grep -q -E 'iommu=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 iommu=force"/' -i /etc/default/grub ; echo "Parameter iommu added."; fi
grub2-mkconfig -o /boot/grub2/grub.cfg  >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-43
echo "HARDE-RHEL-44 : Configurer la connexion Red Hat Subscription Manager"
sed -e s/enabled=1/enabled=0/ -i /etc/yum/pluginconf.d/subscription-manager.conf
# Fin: HARDE-RHEL-44
echo "HARDE-RHEL-45 : Désactiver le démon rhnsd"
systemctl --now disable rhnsd || true
# Fin: HARDE-RHEL-45
echo "HARDE-RHEL-46 : S'assurer que les clés PGP soient configurées"

# Fin: HARDE-RHEL-46
echo "HARDE-RHEL-47 : Activer l'option gpgcheck"

# Fin: HARDE-RHEL-47
echo "HARDE-RHEL-48 : S'assurer que les dépôts soient configurés"

# Fin: HARDE-RHEL-48
echo "HARDE-RHEL-49 : S'assurer que les mises à jour de sécurité sont installées"

# Fin: HARDE-RHEL-49
echo "HARDE-RHEL-50 : Activer le démon cron"
systemctl --now enable crond
# Fin: HARDE-RHEL-50
echo "HARDE-RHEL-51 : Services et démons résidents en mémoire"

# Fin: HARDE-RHEL-51
echo "HARDE-RHEL-52 : Restriction des accès des services déployés"

# Fin: HARDE-RHEL-52
echo "HARDE-RHEL-53 : Durcissement des composants de virtualisation"

# Fin: HARDE-RHEL-53
echo "HARDE-RHEL-54 : Cage chroot et privilèges d'accès du service cloisonné"

# Fin: HARDE-RHEL-54
echo "HARDE-RHEL-55 : Activation et utilisation de chroot par un service"

# Fin: HARDE-RHEL-55
echo "HARDE-RHEL-56 : Ne pas installer xinetd"
dnf remove xinetd || true
# Fin: HARDE-RHEL-56
echo "HARDE-RHEL-57 : S'assurer que le serveur FTP est désactivé"
systemctl --now disable vsftpd || true
# Fin: HARDE-RHEL-57
echo "HARDE-RHEL-58 : S'assurer que le serveur DNS est désactivé"
systemctl --now disable named || true
# Fin: HARDE-RHEL-58
echo "HARDE-RHEL-59 : S'assurer que NFS est désactivé"
systemctl --now disable nfs-server || true
# Fin: HARDE-RHEL-59
echo "HARDE-RHEL-60 : S'assurer que RPC est désactivé"
systemctl --now disable rpcbind || true
# Fin: HARDE-RHEL-60
echo "HARDE-RHEL-61 : S'assurer que le serveur LDAP est désactivé"
systemctl --now disable slapd || true
# Fin: HARDE-RHEL-61
echo "HARDE-RHEL-62 : S'assurer que le serveur DHCP est désactivé"
systemctl --now disable dhcpd || true
# Fin: HARDE-RHEL-62
echo "HARDE-RHEL-63 : S'assurer que le serveur CUPS est désactivé"
systemctl --now disable cups || true
# Fin: HARDE-RHEL-63
echo "HARDE-RHEL-64 : S'assurer que le serveur NIS est désactivé"
systemctl --now disable ypserv || true
# Fin: HARDE-RHEL-64
echo "HARDE-RHEL-65 : S'assurer que l'agent de transfert de mail soit en mode local seulement"

# Fin: HARDE-RHEL-65
echo "HARDE-RHEL-66 : Désactiver le service rsyncd"
systemctl --now disable rsyncd || true
# Fin: HARDE-RHEL-66
echo "HARDE-RHEL-67 : S'assurer que le serveur Avahi est désactivé"
systemctl --now disable avahi-daemon || true
# Fin: HARDE-RHEL-67
echo "HARDE-RHEL-68 : S'assurer que le serveur SNMP est désactivé"
systemctl --now disable snmpd || true
# Fin: HARDE-RHEL-68
echo "HARDE-RHEL-69 : S'assurer que le service Proxy HTTP est désactivé"
systemctl --now disable squid || true
# Fin: HARDE-RHEL-69
echo "HARDE-RHEL-70 : S'assurer que le service Samba  est désactivé"
systemctl --now disable smb || true
# Fin: HARDE-RHEL-70
echo "HARDE-RHEL-71 : S'assurer que le service IMAP/POP3 est désactivé"
systemctl --now disable dovecot || true
# Fin: HARDE-RHEL-71
echo "HARDE-RHEL-72 : S'assurer que le serveur HTTP est désactivé"
systemctl --now disable httpd || true
# Fin: HARDE-RHEL-72
echo "HARDE-RHEL-73 : Désactiver les protocoles DDCP, SCTP, RDS et TIPC"
for i in dccp sctp rds tipc; do
cat >"/etc/modprobe.d/$i.conf" <<EOF
install $i /bin/true
EOF
rmmod "$i" || true ; done
# Fin: HARDE-RHEL-73
echo "HARDE-RHEL-74 : Durcissement et surveillance des services soumis à des flux arbitraires"

# Fin: HARDE-RHEL-74
echo "HARDE-RHEL-75 : Configuration du service local de messagerie"

# Fin: HARDE-RHEL-75
echo "HARDE-RHEL-76 : Alias de messagerie des comptes de service"

# Fin: HARDE-RHEL-76
echo "HARDE-RHEL-77 : S'assurer que firewalld est installé"
dnf install firewalld
# Fin: HARDE-RHEL-77
echo "HARDE-RHEL-78 : Activer le service firewalld"
systemctl --now enable firewalld
# Fin: HARDE-RHEL-78
echo "HARDE-RHEL-79 : Désactiver iptables"
systemctl --now mask iptables
# Fin: HARDE-RHEL-79
echo "HARDE-RHEL-80 : Désactiver nftables"
systemctl --now mask nftables
# Fin: HARDE-RHEL-80
echo "HARDE-RHEL-81 : S'assurer qu'une zone par défaut est définie"
firewall-cmd --set-default-zone=public
# Fin: HARDE-RHEL-81
echo "HARDE-RHEL-82 : S'assurer que les interfaces soient assignées à une zone"
ITF="$(nmcli --terse connection show |awk -F: '{print $1}')"
firewall-cmd --zone=public --change-interface="${ITF}"
# Fin: HARDE-RHEL-82
echo "HARDE-RHEL-83 : Bloquer les services et ports inutiles"
firewall-cmd --remove-service=cockpit
firewall-cmd --runtime-to-permanent
# Fin: HARDE-RHEL-83
echo "HARDE-RHEL-84 : Configurer nftables"

# Fin: HARDE-RHEL-84
echo "HARDE-RHEL-85 : Configurer iptables"

# Fin: HARDE-RHEL-85
echo "HARDE-RHEL-86 : Désactiver les interfaces sans fil"
nmcli radio all off
# Fin: HARDE-RHEL-86
echo "HARDE-RHEL-87 : Activation de SELinux avec la politique targeted"
selinuxenabled || setenforce 1 
fixfiles onboot
# Fin: HARDE-RHEL-87
echo "HARDE-RHEL-88 : Désinstallation des outils de débogage de politique SELinux"
dnf remove settroubleshoot mcstrans
# Fin: HARDE-RHEL-88
echo "HARDE-RHEL-89 : S'assurer que at/cron est restreint aux utilisateurs autorisés"
rm -f /etc/cron.deny
rm -f /etc/at.deny
true > /etc/cron.allow
true > /etc/at.allow
chmod og-rwx /etc/cron.allow
chmod og-rwx /etc/at.allow
chown root:root /etc/cron.allow
chown root:root /etc/at.allow
# Fin: HARDE-RHEL-89
echo "HARDE-RHEL-90 : S'assurer que l'accès SSH soit limité"

# Fin: HARDE-RHEL-90
echo "HARDE-RHEL-91 : S'assurer que l'accès à la commande su est limité"
usermod -a -G wheel root
# Fin: HARDE-RHEL-91
echo "HARDE-RHEL-92 : S'assurer de l'intégrité de la variable PATH pour root"

# Fin: HARDE-RHEL-92
echo "HARDE-RHEL-93 : Imputabilité des opérations d'administration"

# Fin: HARDE-RHEL-93
echo "HARDE-RHEL-94 : Répertoires temporaires dédiés aux comptes"
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
echo "HARDE-RHEL-95 : Activation des profils de sécurité AppArmor"

# Fin: HARDE-RHEL-95
echo "HARDE-RHEL-96 : Paramétrage des booléens SELinux"
setsebool -P allow_execheap=off
setsebool -P allow_execstack=off
# paramètrage appliqué dynamiquement à la fin du processus de boot : setsebool -P secure_mode_insmod=on
# A passer à on si des administrateurs doivent se connecter à distance
echo -n "Autoriser les administrateurs à se connecter par SSH ? "; read -e -i "O" -r ADMINSSH
if [ -z "${ADMINSSH}" ]; then
    setsebool -P ssh_sysadm_login=off
else
    setsebool -P ssh_sysadm_login=on
fi
echo
# Fin: HARDE-RHEL-96
echo "HARDE-RHEL-97 : Confinement des utilisateurs interactifs non privilégiés"
# Find at least one user to add to sudogrp
USER1000="$(grep 1000 /etc/passwd | awk -F: '{print $1}')"
echo -n "Merci de préciser le nom d'un utilisateur à qui donner des droits administrateur [$USER1000] ? " ; read -e -i "$USER1000" -r ADMINUSER
if [ -z "${ADMINUSER}" ]; then
    ADMINUSER="${USER1000}"
fi
groupadd -r -f sudogrp
echo "%sudogrp    ALL=(ALL)  TYPE=unconfined_t ROLE=unconfined_r    ALL" >/etc/sudoers.d/15group
#usermod -Z sysadm_u "${ADMINUSER}"
semanage login -a -s staff_u -rs0:c0.c1023 "${ADMINUSER}" || true
usermod -G sudogrp "${ADMINUSER}"
# For unprivileged user, use usermod -Z user_u <unprivileged>
semanage login -m -r s0 -s user_u __default__
# restorecon is required at this point and will be performed on reboot
# Fin: HARDE-RHEL-97
echo "HARDE-RHEL-98 : Utiliser une source de temps"
dnf install chrony
# Fin: HARDE-RHEL-98
echo "HARDE-RHEL-99 : S'assurer que chrony est configuré"

# Fin: HARDE-RHEL-99
echo "HARDE-RHEL-100 : Service autofs désactivé"

# Fin: HARDE-RHEL-100
echo "HARDE-RHEL-101 : Supprimer le serveur X"
dnf remove xorg-x11*.*
# Fin: HARDE-RHEL-101
echo "HARDE-RHEL-102 : S'assurer que le client NIS n'est pas installé"
dnf remove ypbind
# Fin: HARDE-RHEL-102
echo "HARDE-RHEL-103 : S'assurer que le client telnet n'est pas installé"
dnf remove telnet
# Fin: HARDE-RHEL-103
echo "HARDE-RHEL-104 : S'assurer que le client ldap n'est pas installé"

# Fin: HARDE-RHEL-104
echo "HARDE-RHEL-105 : S'assurer que le paramètre SSH AllowTcpForwarding est désactivé"
sed -i -e 's/\(^AllowTcpForwarding yes\)/\#HARDE-RHEL-105: \1/' /etc/ssh/sshd_config
if ! grep -q -E '^AllowTcpForwarding' /etc/ssh/sshd_config ; then echo "AllowTcpForwarding no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-105
echo "HARDE-RHEL-106 : S'assurer que le transfert X11 SSH est désactivé"
sed -i -e 's/\(^X11Forwarding yes\)/\#HARDE-RHEL-106: \1/' /etc/ssh/sshd_config
if  ! grep -q -E '^X11Forwarding\s+no' /etc/ssh/sshd_config ; then echo "X11Forwarding no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-106
echo "HARDE-RHEL-107 : Installer sudo"
dnf install sudo
# Fin: HARDE-RHEL-107
echo "HARDE-RHEL-108 : S'assurer que les commandes sudo utilisent un pseudo-TTY et autres directives"
cat >/etc/sudoers.d/10secure <<EOF
#Defaults noexec
#Defaults use_pty
Defaults requiretty,umask=0027
Defaults ignore_dot,env_reset,passwd_timeout=1
Defaults timestamp_timeout=5
EOF
# Fin: HARDE-RHEL-108
echo "HARDE-RHEL-109 : Afficher des bannières lors de la connexion"
for i in /etc/motd /etc/issue /etc/issue.net; do
cat >"$i" <<EOF
***************************************************************************
*L’utilisation d’un poste classifié n’est autorisée qu’aux personnes ayant* 
*le niveau d’habilitation requis.                                         *
*Tout manquement à cette règle est considéré comme une compromission du   *
* secret de la défense nationale et entraine une poursuite judicaire.     *    
*                                  (Art. 66. IGI 1300 du 30 novembre 2011)* 
***************************************************************************
EOF
done
# Fin: HARDE-RHEL-109
echo "HARDE-RHEL-110 : S'assurer que le paramètre SSH root login est désactivé"
sed -i -e 's/\(^PermitRootLogin yes\)/\#HARDE-RHEL-110: \1/' /etc/ssh/sshd_config
if  ! grep -q -E '^PermitRootLogin\s+no' /etc/ssh/sshd_config ; then echo "PermitRootLogin no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-110
echo "HARDE-RHEL-111 : S'assurer que le paramètre SSH PermitEmptyPasswords est désactivé"
if  ! grep -q -E '^PermitEmptyPasswords\s+no' /etc/ssh/sshd_config ; then echo "PermitEmptyPasswords no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-111
echo "HARDE-RHEL-112 : S'assurer que le paramètre SSH PermitUserEnvironment est désactivé"
if  ! grep -q -E '^PermitUserEnvironment\s+no' /etc/ssh/sshd_config ; then echo "PermitUserEnvironment no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-112
echo "HARDE-RHEL-113 : S'assurer que le paramètre SSH Idle Timeout Interval est configuré"
if  ! grep -q -E '^Client' /etc/ssh/sshd_config ; then echo -e "ClientAliveInterval 300\nClientAliveCountMax 0">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-113
echo "HARDE-RHEL-114 : S'assurer que le paramètre SSH LoginGraceTime est positionné à une minute ou moins"
if  ! grep -q -E '^LoginGraceTime' /etc/ssh/sshd_config ; then echo "LoginGraceTime 60">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-114
echo "HARDE-RHEL-115 : S'assurer que la bannière SSH est configurée"
if  ! grep -q -E '^Banner' /etc/ssh/sshd_config ; then echo "Banner /etc/issue.net">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-115
echo "HARDE-RHEL-116 : S'assurer que le paramètrage SSH PAM est activé"
if  ! grep -q -E '^UsePAM' /etc/ssh/sshd_config ; then echo "UsePAM yes">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-116
echo "HARDE-RHEL-117 : S'assurer que le paramètre SSH MaxStartups est configuré"
if  ! grep -q -E '^MaxStartups' /etc/ssh/sshd_config ; then echo "MaxStartups 10:30:60">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-117
echo "HARDE-RHEL-118 : S'assurer que le paramètre SSH MaxSessions est positionné à 4 ou moins"
 if  ! grep -q -E '^MaxSessions' /etc/ssh/sshd_config ; then echo "MaxSessions 4">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-118
echo "HARDE-RHEL-119 : S'assurer que le paramètre SSH MaxAuthTries est positionné à 4 ou moins"
echo "MaxAuthTries 4">>/etc/ssh/sshd_config
# Fin: HARDE-RHEL-119
echo "HARDE-RHEL-120 : S'assurer que le paramètre SSH IgnoreRhosts est activé"
if  ! grep -q -E '^IgnoreRhosts\s+yes' /etc/ssh/sshd_config ; then echo "IgnoreRhosts yes">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-120
echo "HARDE-RHEL-121 : S'assurer que le paramètre SSH HostbasedAuthentication est désactivé"
if  ! grep -q -E '^HostbasedAuthentication\s+no' /etc/ssh/sshd_config ; then echo "HostbasedAuthentication no">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-121
echo "HARDE-RHEL-122 : Créer un profil authselect personnalisé"

# Fin: HARDE-RHEL-122
echo "HARDE-RHEL-123 : Selectionner le profil authselect"

# Fin: HARDE-RHEL-123
echo "HARDE-RHEL-124 : S'assurer que le paramètrage authselect inclus with-faillock"

# Fin: HARDE-RHEL-124
echo "HARDE-RHEL-125 : S'assurer que les exigences de création de mot de passe soient correctes"
if  ! grep -q -E '^minlen' /etc/security/pwquality.conf ; then echo "minlen = 9">> /etc/security/pwquality.conf; fi
if  ! grep -q -E '^minclass' /etc/security/pwquality.conf ; then echo "minclass = 4">> /etc/security/pwquality.conf; fi
if  ! grep -q -E '^gecoscheck' /etc/security/pwquality.conf ; then echo "gecoscheck = 1">> /etc/security/pwquality.conf; fi
if  ! grep -q -E '^usercheck' /etc/security/pwquality.conf ; then echo "usercheck = 1">> /etc/security/pwquality.conf; fi
# Fin: HARDE-RHEL-125
echo "HARDE-RHEL-126 : S'assurer que le verrouillage après des tentatives de connexion soit configuré"
    echo "HARDE-RHEL-137"
# Fin: HARDE-RHEL-126
echo "HARDE-RHEL-127 : S'assurer que la réutilisation d'anciens mots de passe soit limitée"

# Fin: HARDE-RHEL-127
echo "HARDE-RHEL-128 : Protection des mots de passe stockés"
if ! grep -q -E '^ENCRYPT_METHOD\s+SHA512' /etc/login.defs ; then sed -e 's/\(ENCRYPT_METHOD.*\)/# \1/' -i /etc/login.defs; echo "ENCRYPT_METHOD SHA512" >> /etc/login.defs; fi
if ! grep -q -E '^SHA_CRYPT_MIN_ROUNDS\s+65536' /etc/login.defs ; then sed -e 's/\(SHA_CRYPT_MIN_ROUNDS.*\)/# \1/' -i /etc/login.defs; echo "SHA_CRYPT_MIN_ROUNDS 65536" >> /etc/login.defs; fi
AUTH_FILES=(
    [0]="/etc/pam.d/system-auth"
    [1]="/etc/pam.d/password-auth"
)
for pamFile in "${AUTH_FILES[@]}"
do
    # suppress partial config and nullok
    sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ nullok//" "$pamFile"
    sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ sha512//" "$pamFile"
    sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ obscure//" "$pamFile"
    sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ rounds=65536//" "$pamFile"
    if ! grep -q "^password.*sufficient.*pam_unix.so.*obscure sha512 rounds=65536" "$pamFile"; then
	sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/$/ obscure sha512 rounds=65536/" "$pamFile"
    fi
done
# Fin: HARDE-RHEL-128
echo "HARDE-RHEL-129 : S'assurer que l'expiration des mots de passe soit de 365 jours ou moins"
if  ! grep -q -E '^PASS_MAX_DAYS\s+365' /etc/login.defs ; then sed -e 's/\(PASS_MAX_DAYS.*\)/# \1/' -i /etc/login.defs; echo "PASS_MAX_DAYS 365" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-129
echo "HARDE-RHEL-130 : S'assurer que le nombre minimum de jours entre 2 changements de mot de passe soit 7 ou plus"
if  ! grep -q -E '^PASS_MIN_DAYS\s+365' /etc/login.defs ; then sed -e 's/\(PASS_MIN_DAYS.*\)/# \1/' -i /etc/login.defs; echo "PASS_MIN_DAYS 7" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-130
echo "HARDE-RHEL-131 : S'assurer que l'alerte pour expiration de mot de passe soit émise 7 jours ou plus avant expiration du mot de passe"
if  ! grep -q -E '^PASS_WARN_AGE\s+14' /etc/login.defs ; then sed -e 's/\(PASS_WARN_AGE.*\)/# \1/' -i /etc/login.defs; echo "PASS_WARN_AGE 14" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-131
echo "HARDE-RHEL-132 : S'assurer que le verrouillage des comptes inutilisés soit de 30 jours ou moins"
useradd -D -f 30
# Fin: HARDE-RHEL-132
echo "HARDE-RHEL-133 : S'assurer que toutes les dates de changement de mot de passe soient dans le passé"
PATH=/sbin:$PATH awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print $1}' /etc/passwd | while read -r user ; do usermod -s "$(which nologin)" "${user}"; done
awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}' | while read -r user; do usermod -L "${user}" ; done
# Fin: HARDE-RHEL-133
echo "HARDE-RHEL-134 : S'assurer que les comptes système soient sécurisés"
chage -d 0 root
chage -d 0 "${ADMINUSER}"
# Fin: HARDE-RHEL-134
echo "HARDE-RHEL-135 : S'assurer que la temporisation par défaut des shell utilisateurs soit de 900 secondes ou moins"
cat >/etc/profile.d/tmout.sh <<EOF
readonly TMOUT=900 ; export TMOUT
EOF
# Fin: HARDE-RHEL-135
echo "HARDE-RHEL-136 : S'assurer que le groupe par défaut du compte root est 0"
usermod -g 0 root
# Fin: HARDE-RHEL-136
echo "HARDE-RHEL-137 : S'assurer que la connexion est root est seulement possible sur la console system"
for i in 1 2 3 4 5 6; do echo "tty$i" >> /etc/securetty; done
# enable pam_securetty.so as well
cat >/etc/pam.d/system-auth <<EOF
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authselect is run.
auth        required      pam_env.so
auth        required      pam_securetty.so noconsole
auth        sufficient    pam_unix.so try_first_pass
auth        required      pam_faillock.so preauth silent deny=5 unlock_time=900
auth        required      pam_faillock.so authfail deny=5 unlock_time=900
auth        required      pam_deny.so

account     required      pam_unix.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
password    requisite     pam_pwhistory.so use_authtok remember=99
password    sufficient    pam_unix.so try_first_pass use_authtok shadow obscure sha512 rounds=65536
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
EOF
cp /etc/pam.d/system-auth /etc/pam.d/password-auth
# Fin: HARDE-RHEL-137
echo "HARDE-RHEL-138 : S'assurer qu'aucun mot de passe n'est vide"

# Fin: HARDE-RHEL-138
echo "HARDE-RHEL-139 : S'assurer que qu'aucune entrée dans /etc/passwd n'utilise le code historique \"+\""

# Fin: HARDE-RHEL-139
echo "HARDE-RHEL-140 : S'assurer que qu'aucune entrée dans /etc/shadow n'utilise le code historique \"+\""

# Fin: HARDE-RHEL-140
echo "HARDE-RHEL-141 : S'assurer que qu'aucune entrée dans /etc/group n'utilise le code historique \"+\""

# Fin: HARDE-RHEL-141
echo "HARDE-RHEL-142 : S'assurer que root est le seul compte avec UID 0"

# Fin: HARDE-RHEL-142
echo "HARDE-RHEL-143 : Désactivation des comptes utilisateurs inutilisés"

# Fin: HARDE-RHEL-143
echo "HARDE-RHEL-144 : Désactivation des comptes de services"

# Fin: HARDE-RHEL-144
echo "HARDE-RHEL-145 : Unicité et exclusivité des comptes de services"

# Fin: HARDE-RHEL-145
echo "HARDE-RHEL-146 : Délai d'expiration de sessions utilisateurs"

# Fin: HARDE-RHEL-146
echo "HARDE-RHEL-147 : Applications utilisant PAM"

# Fin: HARDE-RHEL-147
echo "HARDE-RHEL-148 : Sécurisation des services réseau d'authentification PAM"
cat >/etc/pam.d/su <<EOF
#%PAM-1.0
auth            required        pam_env.so
auth            sufficient      pam_rootok.so
# Uncomment the following line to implicitly trust users in the ""wheel"" group.
#auth           sufficient      pam_wheel.so trust use_uid
# Uncomment the following line to require a user to be in the ""wheel"" group.
#auth           required        pam_wheel.so use_uid
# The following line requires a user to be in the ""sudogrp"" group.
auth            required        pam_wheel.so group=sudogrp
auth            substack        system-auth
auth            include         postlogin
account         sufficient      pam_succeed_if.so uid = 0 use_uid quiet
account         include         system-auth
password        include         system-auth
session         include         system-auth
session         include         postlogin
session         optional        pam_xauth.so
EOF
# Fin: HARDE-RHEL-148
echo "HARDE-RHEL-149 : Sécurisation des accès aux bases utilisateurs distantes"

# Fin: HARDE-RHEL-149
echo "HARDE-RHEL-150 : Séparation des comptes système et d'administrateur de l'annuaire"

# Fin: HARDE-RHEL-150
echo "HARDE-RHEL-151 : Groupe dédié à l'usage de sudo"
#cat >/etc/sudoers.d/15group <<EOF
#%sudogrp ALL=(ALL) ALL
#EOF
groupadd -r -f sudogrp
chgrp sudogrp /usr/bin/sudo
chmod u+s /usr/bin/sudo
chmod o-rwx /usr/bin/sudo
# Fin: HARDE-RHEL-151
echo "HARDE-RHEL-152 : Authentification des utilisateurs exécutant sudo"
grep -q -E "^[^#].*NOPASSWD" /etc/sudoers  && echo "Directive NOPASSWD à supprimer du fichier /etc/sudoers"
# Fin: HARDE-RHEL-152
echo "HARDE-RHEL-153 : Privilèges des utilisateurs cibles pour une commande sudo"

# Fin: HARDE-RHEL-153
echo "HARDE-RHEL-154 : Limitation du nombre de commandes nécessitant l'option EXEC"

# Fin: HARDE-RHEL-154
echo "HARDE-RHEL-155 : Du bon usage de la négation dans une spécification sudo"

# Fin: HARDE-RHEL-155
echo "HARDE-RHEL-156 : Arguments explicites dans les spécifications sudo"

# Fin: HARDE-RHEL-156
echo "HARDE-RHEL-157 : Du bon usage de sudoedit"

# Fin: HARDE-RHEL-157
echo "HARDE-RHEL-158 : Sticky bit et droits d'accès en écriture"

# Fin: HARDE-RHEL-158
echo "HARDE-RHEL-159 : Installer AIDE"
dnf install aide
# Fin: HARDE-RHEL-159
echo "HARDE-RHEL-160 : Vérification régulière de l'intégrité de système de fichiers"
cat >/etc/systemd/system/aidecheck.timer <<EOF
[Unit]
Description=Aide check every day at midnight

[Timer]
OnCalendar=*-*-* 00:00:00
Unit=aidecheck.service

[Install]
WantedBy=multi-user.target
EOF
cat >/etc/systemd/system/aidecheck.service <<EOF
[Unit]
Description=Aide Check

[Service]
Type=simple
ExecStart=/sbin/aide --check

[Install]
WantedBy=multi-user.target
EOF
chmod 0644 /etc/systemd/system/aidecheck.*
systemctl reenable aidecheck.timer
systemctl restart aidecheck.timer
systemctl daemon-reload
# do this at the end, to minimize the number of changes
# aide --init
# mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
# Fin: HARDE-RHEL-160
echo "HARDE-RHEL-161 : S'assurer que les permissions sur /etc/crontab soient correctes"
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
# Fin: HARDE-RHEL-161
echo "HARDE-RHEL-162 : S'assurer que les permissions sur /etc/cron.hourly soient correctes"
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
# Fin: HARDE-RHEL-162
echo "HARDE-RHEL-163 : S'assurer que les permissions sur /etc/cron.daily soient correctes"
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
# Fin: HARDE-RHEL-163
echo "HARDE-RHEL-164 : S'assurer que les permissions sur /etc/cron.weekly soient correctes"
chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
# Fin: HARDE-RHEL-164
echo "HARDE-RHEL-165 : S'assurer que les permissions sur /etc/cron.monthly soient correctes"
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
# Fin: HARDE-RHEL-165
echo "HARDE-RHEL-166 : S'assurer que les permissions sur /etc/cron.d soient correctes"
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
# Fin: HARDE-RHEL-166
echo "HARDE-RHEL-167 : S'assurer que les permissions sur /etc/ssh/sshd_config soient correctes"
chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config
# Fin: HARDE-RHEL-167
echo "HARDE-RHEL-168 : S'assurer que les permissions sur les clés privées d'hôte SSH soient correctes"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chown root:root "{}" ";"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key' -exec chmod 0600 "{}" ";"
# Fin: HARDE-RHEL-168
echo "HARDE-RHEL-169 : S'assurer que les permissions sur les clés publiques d'hôte soient correctes"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chmod 0644 "{}" ";"
find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chown root:root "{}" ";"
# Fin: HARDE-RHEL-169
echo "HARDE-RHEL-170 : S'assurer que l'umask utilisateur est ou plus restrictif"
# Shells non-interactifs
sed -i -e 's/umask 0../umask 027/' /etc/bashrc
# Shells interactifs
cat >/etc/profile.d/umask.sh <<EOF
umask 027
EOF
# Fin: HARDE-RHEL-170
echo "HARDE-RHEL-171 : Auditer les permissions du système de fichiers"

# Fin: HARDE-RHEL-171
echo "HARDE-RHEL-172 : S'assurer qu'aucun fichier en écriture pour tout le monde n'existe"

# Fin: HARDE-RHEL-172
echo "HARDE-RHEL-173 : S'assurer que tous les fichiers ont un propriétaire"

# Fin: HARDE-RHEL-173
echo "HARDE-RHEL-174 : S'assurer que tous les fichiers ont un groupe"

# Fin: HARDE-RHEL-174
echo "HARDE-RHEL-175 : Auditer les exécutables SUID"
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 -ls > "$HOME/$0-suid-$(date +'%Y-%m-%d').txt"
# Fin: HARDE-RHEL-175
echo "HARDE-RHEL-176 : Auditer les exécutables SGID"
df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 -ls > "$HOME/$0-sgid-$(date +'%Y-%m-%d').txt"
# Fin: HARDE-RHEL-176
echo "HARDE-RHEL-177 : S'assurer que les permissions sur /etc/passwd soient correctes"
chown root:root /etc/passwd
chmod 644 /etc/passwd
# Fin: HARDE-RHEL-177
echo "HARDE-RHEL-178 : S'assurer que les permissions sur /etc/shadow soient correctes"
chown root:root /etc/shadow
chmod o-rwx,g-wx /etc/shadow
# Fin: HARDE-RHEL-178
echo "HARDE-RHEL-179 : S'assurer que les permissions sur /etc/group soient correctes"
chown root:root /etc/group
chmod 644 /etc/group
# Fin: HARDE-RHEL-179
echo "HARDE-RHEL-180 : S'assurer que les permissions sur /etc/gshadow soient correctes"
chown root:root /etc/gshadow
chmod o-rwx,g-rw /etc/gshadow
# Fin: HARDE-RHEL-180
echo "HARDE-RHEL-181 : S'assurer que les permissions sur /etc/passwd- soient correctes"
chown root:root /etc/passwd-
chmod u-x,go-rwx /etc/passwd-
# Fin: HARDE-RHEL-181
echo "HARDE-RHEL-182 : S'assurer que les permissions sur /etc/shadow- soient correctes"
chown root:root /etc/shadow-
chmod u-x,go-rwx /etc/shadow-
# Fin: HARDE-RHEL-182
echo "HARDE-RHEL-183 : S'assurer que les permissions sur /etc/group- soient correctes"
chown root:root /etc/group-
chmod u-x,go-wx /etc/group-
# Fin: HARDE-RHEL-183
echo "HARDE-RHEL-184 : S'assurer que les permissions sur /etc/gshadow- soient correctes"
chown root:root /etc/gshadow-
chmod o-rwx,g-rw /etc/gshadow-
# Fin: HARDE-RHEL-184
echo "HARDE-RHEL-185 : S'assurer que les utilisateurs n'ont pas de fichier .forward"

# Fin: HARDE-RHEL-185
echo "HARDE-RHEL-186 : S'assurer que les utilisateurs n'ont pas de fichier .netrc"

# Fin: HARDE-RHEL-186
echo "HARDE-RHEL-187 : S'assurer que les fichiers .netrc ne soint pas accessibles en écriture"

# Fin: HARDE-RHEL-187
echo "HARDE-RHEL-188 : S'assurer qu'il n'existe pas de fichier .rhosts"

# Fin: HARDE-RHEL-188
echo "HARDE-RHEL-189 : S'assurer que tous les groupes de /etc/passwd existent dans /etc/group"

# Fin: HARDE-RHEL-189
echo "HARDE-RHEL-190 : S'assurer qu'il n'y a pas d'UIDs dupliqués"

# Fin: HARDE-RHEL-190
echo "HARDE-RHEL-191 : S'assurer qu'il n'y a pas de GIDs dupliqués"

# Fin: HARDE-RHEL-191
echo "HARDE-RHEL-192 : S'assurer qu'il n'y a pas de de doublons dans les noms d'utilisateur"

# Fin: HARDE-RHEL-192
echo "HARDE-RHEL-193 : S'assurer que qu'il n'y a pas de de doublons dans les noms de groupe"

# Fin: HARDE-RHEL-193
echo "HARDE-RHEL-194 : S'assurer qu'il n'y a pas de groupe shadow"

# Fin: HARDE-RHEL-194
echo "HARDE-RHEL-195 : Vérifier que tous les utilisateurs aient un répertoire d'accueil"

# Fin: HARDE-RHEL-195
echo "HARDE-RHEL-196 : S'assurer que les permissions sur les répertoire d'accueil des utilisateurs soit 750 ou plus restrictif"

# Fin: HARDE-RHEL-196
echo "HARDE-RHEL-197 : S'assurer que les utilisateurs possèdent leurs répertoires d'accueil"

# Fin: HARDE-RHEL-197
echo "HARDE-RHEL-198 : S'assurer que les fichiers de configuration des utilisateurs ne soient pas ouverts en écriture au groupe ou à tout le monde"

# Fin: HARDE-RHEL-198
echo "HARDE-RHEL-199 : Droits d'accès aux fichiers de contenu sensible"

# Fin: HARDE-RHEL-199
echo "HARDE-RHEL-200 : Sécurisation des accès pour les sockets et pipes"

# Fin: HARDE-RHEL-200
echo "HARDE-RHEL-201 : Protection de la base de données des scellés"

# Fin: HARDE-RHEL-201
echo "HARDE-RHEL-202 : Désactiver la création de core dumps"
cat >/etc/sysctl.d/15suid_dumpable.conf <<EOF
# Pas de core dump des exécutables setuid
fs.suid_dumpable = 0
EOF
cat >/etc/security/limits.d/10core.conf <<EOF
* hard core 0
EOF
# Fin: HARDE-RHEL-202
echo "HARDE-RHEL-203 : Activer l'aléatoire dans l'organisation de l'espace d'adressage"
cat >/etc/sysctl.d/20aslr.conf <<EOF
# Activation de l'ASLR
kernel.randomize_va_space = 2
EOF
# Fin: HARDE-RHEL-203
echo "HARDE-RHEL-204 : Paramètrage des sysctl système"
cat >/etc/sysctl.d/10anssi.conf <<EOF
# Désactivation des SysReq
kernel.sysrq = 0
# Interdiction de déréférencer des liens vers des fichiers dont
# l'utilisateur courant n'est pas le propriétaire
# Peut empêcher certains programmes de fonctionner correctement
fs.protected_symlinks = 1
fs.protected_hardlinks = 1
# Interdiction de mapper de la mémoire dans les adresses basses (0)
vm.mmap_min_addr = 65536
# Espace de choix plus grand pour les valeurs de PID
kernel.pid_max = 65536
# Obfuscation des adresses mémoire kernel
kernel.kptr_restrict = 1
# Restriction d'accès au buffer dmesg
kernel.dmesg_restrict = 1
# Restreint l'utilisation du sous système perf
kernel.perf_event_paranoid = 2
kernel.perf_event_max_sample_rate = 1
kernel.perf_cpu_time_max_percent = 1
EOF
# Fin: HARDE-RHEL-204
echo "HARDE-RHEL-205 : Désactivation du chargement des modules noyau"
cat >/etc/maintenance_mode.sh <<EOF
#! /bin/bash
if [ ! -f /SECURE_INSMOD_DISABLED ] ; then
    touch /SECURE_INSMOD_DISABLED
fi
echo Reboot is required to allow module loading.
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
        rm "/etc/modprobe.d/\$module.conf"
    done
    setsebool secure_mode_insmod off
    echo "Secure insmod is DISABLED."
    mount /boot
    mount /boot/efi
    rm -f /SECURE_INSMOD_DISABLED
fi
exit 1 
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
echo "HARDE-RHEL-206 : Configuration sysctl du module Yama"
cat >/etc/sysctl.d/25yama.conf <<EOF
kernel.yama.ptrace_scope = 1
EOF
# Fin: HARDE-RHEL-206
echo "HARDE-RHEL-207 : Partition séparée pour /var/log"
mount | grep -q -E '/var/log\s' || exit 7
# Fin: HARDE-RHEL-207
echo "HARDE-RHEL-208 : Partition séparée pour /var/log/audit"
mount | grep -q -E '/var/log/audit\s' || exit 8
# Fin: HARDE-RHEL-208
echo "HARDE-RHEL-209 : Journal spécifique pour sudo"
cat >/etc/sudoers.d/05log <<EOF
Defaults logfile="/var/log/sudo/sudo.log"
EOF
mkdir /var/log/sudo
semanage fcontext --add -t sudo_log_t /var/log/sudo 
restorecon -R -v /var/log/sudo
# Fin: HARDE-RHEL-209
echo "HARDE-RHEL-210 : S'assurer qu'auditd est installé"
dnf install audit audit-libs
# Fin: HARDE-RHEL-210
echo "HARDE-RHEL-211 : S'assurer que le service auditd est activé"
systemctl --now enable auditd
# Fin: HARDE-RHEL-211
echo "HARDE-RHEL-212 : S'assurer que l'audit commence au plus tôt"
if ! grep -q -E 'auditd=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 auditd=1"/' -i /etc/default/grub ; echo "Parameter auditd added."; fi
grub2-mkconfig –o /boot/grub2/grub.cfg >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-212
echo "HARDE-RHEL-213 : S'assurer que la valeur d'audit_backlog_limit est suffisante"
if ! grep -q -E 'audit_backlog_limit=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 audit_backlog_limit=8192"/' -i /etc/default/grub ; echo "Parameter audit_backlog_limit added."; fi
grub2-mkconfig –o /boot/grub2/grub.cfg >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-213
echo "HARDE-RHEL-214 : Tracer les tentatives d'accès aux fichiers refusées "
cat >/etc/audit/rules.d/35access.rules <<EOF
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
EOF
# Fin: HARDE-RHEL-214
echo "HARDE-RHEL-215 : Tracer les modifications d'utilisateurs"
cat >/etc/audit/rules.d/40identity.rules <<EOF
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
EOF
# Fin: HARDE-RHEL-215
echo "HARDE-RHEL-216 : Journalisation de l'activité par auditd"
cat >/etc/audit/rules.d/00audit.rules<<EOF
## First rule - delete all
-D
## Increase the buffers to survive stress events.
## Make this bigger for busy systems
-b 8192
## This determine how long to wait in burst of events
--backlog_wait_time 60000
## Set failure mode to syslog
-f 1
EOF
cat >/etc/audit/rules.d/10etc.rules <<EOF
# Journaliser les modifications dans /etc/
-w /etc/ -p wa
EOF
cat >/etc/audit/rules.d/20mount.rules<<EOF
# Surveillance de montage/démontage
-a exit,always -S mount -S umount2 -k mounts
EOF
cat >/etc/audit/rules.d/30syscalls.rules <<EOF
# Appels de syscalls x86 suspects
-a exit,always -S ioperm -S modify_ldt
# Appels de syscalls qui doivent être rares et surveillés de près
-a exit,always -S get_kernel_syms -S ptrace
-a exit,always -S prctl
EOF
# Fin: HARDE-RHEL-216
echo "HARDE-RHEL-217 : Tracer l'utilisation des commandes privilégiés"
find / /usr /srv -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>='"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' -F auid!=4294967295 -k privileged" }' > /etc/audit/rules.d/25privileged.rules
# Fin: HARDE-RHEL-217
echo "HARDE-RHEL-218 : Tracer les suppressions de fichiers"
cat >/etc/audit/rules.d/45delete.rules <<EOF
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
EOF
# Fin: HARDE-RHEL-218
echo "HARDE-RHEL-219 : Tracer le chargement/déchargement de modules"
cat >/etc/audit/rules.d/50modules.rules <<EOF
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-a always,exit -F arch=b64 -S init_module -S delete_module -k modules
EOF
# Fin: HARDE-RHEL-219
echo "HARDE-RHEL-220 : Tracer les actions des administrateurs"
cat >/etc/audit/rules.d/55actions.rules <<EOF
-w /var/log/sudo.log -p wa -k actions
EOF
# Fin: HARDE-RHEL-220
echo "HARDE-RHEL-221 : S'assurer que la configuration auditd n'est pas modifiable"
cat >/etc/audit/rules.d/zz_lock.rules <<EOF
# Verrouillage de la configuration de auditd
-e 2
EOF
# Fin: HARDE-RHEL-221
echo "HARDE-RHEL-222 : S'assurer que la taille de stockage est spécifiée"
if  ! grep -q -E '^max_log_file = 8' /etc/audit/auditd.conf ; then sed -e 's/\(max_log_file .*\)/#HARDE-RHEL-222: \1/' -i /etc/audit/auditd.conf; echo "max_log_file = 8" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-222
echo "HARDE-RHEL-223 : S'assurer que les logs d'audit ne soient pas purgés"
if  ! grep -q -E '^max_log_file_action = keep_logs' /etc/audit/auditd.conf ; then sed -e 's/\(max_log_file_action.*\)/#HARDE-RHEL-223: \1/' -i /etc/audit/auditd.conf; echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-223
echo "HARDE-RHEL-224 : S'assurer que le système s'arrête si le système d'audit est plein"
if  ! grep -q -E '^admin_space_left_action = halt' /etc/audit/auditd.conf ; then sed -e 's/\(admin_space_left_action .*\)/#HARDE-RHEL-224: \1/' -i /etc/audit/auditd.conf; echo "admin_space_left_action = halt" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-224
echo "HARDE-RHEL-225 : Auditer tout changement du fichier sudoers"
cat >/etc/audit/rules.d/60scope.rules<<EOF
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
EOF
# Fin: HARDE-RHEL-225
echo "HARDE-RHEL-226 : Auditer toute connexion/déconnexion"
cat > /etc/audit/rules.d/65audit.rules<<EOF
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
EOF
# Fin: HARDE-RHEL-226
echo "HARDE-RHEL-227 : Collecter toutes les informations de session"
cat >/etc/audit/rules.d/70logins.rules<<EOF
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k logins
-w /var/log/btmp -p wa -k logins
EOF
# Fin: HARDE-RHEL-227
echo "HARDE-RHEL-228 : S'assurer que les évenement de changements horaires soient tracés"
cat >/etc/audit/rules.d/75time-change.rules <<EOF
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
-a always,exit -F arch=b64 -S clock_settime -k time-change
-a always,exit -F arch=b32 -S clock_settime -k time-change
-w /etc/localtime -p wa -k time-change
EOF
# Fin: HARDE-RHEL-228
echo "HARDE-RHEL-229 : S'assurer que les événements modifiant les MAC soient collectéees"
cat >/etc/audit/rules.d/80MAC-policy.rules<<EOF
-w /etc/selinux/ -p wa -k MAC-policy
-w /usr/share/selinux/ -p wa -k MAC-policy
EOF
# Fin: HARDE-RHEL-229
echo "HARDE-RHEL-230 : Tracer les événements changeant l'environnement réseau"
cat >/etc/audit/rules.d/85system-locale.rules <<EOF
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/sysconfig/network -p wa -k system-locale
EOF
# Fin: HARDE-RHEL-230
echo "HARDE-RHEL-231 : Tracer les changements de permission"
cat > /etc/audit/rules.d/90perm_mod.rules <<EOF
-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=4294967295 -k perm_mod
EOF
# Fin: HARDE-RHEL-231
echo "HARDE-RHEL-232 : Installer le service rsyslog"
dnf install rsyslog
# Fin: HARDE-RHEL-232
echo "HARDE-RHEL-233 : Activer le service syslog"
systemctl --now enable rsyslog
# Fin: HARDE-RHEL-233
echo "HARDE-RHEL-234 : Configurer les permissions des fichiers journaux"
cat > /etc/rsyslog.d/10FileCreate.conf <<EOF
\$FileCreateMode 0640
EOF
# Fin: HARDE-RHEL-234
echo "HARDE-RHEL-235 : Définir les fichiers journaux"
cat >/etc/rsyslog.d/files.conf <<EOF
# Everybody gets emergency messages
*.emerg			:omusrmsg:*
# The authpriv file has restricted access.
auth,authpriv.*		/var/log/secure
# Log cron stuff
cron.*			/var/log/cron
mail.* 			-/var/log/mail
mail.info 		-/var/log/mail.info
mail.warning 		-/var/log/mail.warn
mail.err 		/var/log/mail.err
news.crit 		-/var/log/news/news.crit
news.err 		-/var/log/news/news.err
news.notice 		-/var/log/news/news.notice
*.=warning;*.=err 	-/var/log/warn
*.crit 			/var/log/warn
# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none	-/var/log/messages
local0.*,local1.* 	-/var/log/localmessages
local2.*,local3.* 	-/var/log/localmessages
local4.*,local5.* 	-/var/log/localmessages
local6.*		-/var/log/localmessages
local7.*		/var/log/boot.log
# Save news errors of level crit and higher in a special file.
uucp,news.crit		/var/log/spooler
EOF
# Fin: HARDE-RHEL-235
echo "HARDE-RHEL-236 : Renvoyer les journaux vers un hôte distant"
# ask for the syslog server
echo -n "Merci de préciser l'adresse ou le nom du serveur SYSLOG distant :"; read -e -i '127.0.0.1' -r SYSLOGSERVER
cat > /etc/rsyslog.d/loghost.conf <<EOF
# TCP version *.*     @@$SYSLOGSERVER:514
*.*     @$SYSLOGSERVER:514
EOF
# Fin: HARDE-RHEL-236
echo "HARDE-RHEL-237 : S'assurer que seuls les puits de logs peuvent recevoir des logs"

# Fin: HARDE-RHEL-237
echo "HARDE-RHEL-238 : S'assurer que journald est redirigé vers rsyslog"
systemctl stop systemd-journald
systemctl disable systemd-journald
mkdir -p /etc/systemd/journald.conf.d/ 
cat > /etc/systemd/journald.conf.d/00-forwardsyslog.conf <<EOF
[Journal]
ForwardToSyslog=yes
EOF
# Fin: HARDE-RHEL-238
echo "HARDE-RHEL-239 : S'assurer que journald compresse les journaux de grande taille"
cat > /etc/systemd/journald.conf.d/10-compress.conf <<EOF
[Journal]
Compress=yes
EOF
# Fin: HARDE-RHEL-239
echo "HARDE-RHEL-240 : S'assurer que journald écrit les journaux sur disque"
cat > /etc/systemd/journald.conf.d/20-persistent.conf <<EOF
[Journal]
Storage=persistent
EOF
# Fin: HARDE-RHEL-240
echo "HARDE-RHEL-241 : S'assurer de la permission des fichiers journaux"
# this is a one time solution since systemd resets permissions on reboot
#   find /var/log -type f -exec chmod g-wx,o-rwx "{}" + -o -type d -exec chmod g-w,o-rwx "{}" ";"
# systemd way:
sed -e 's,d /var/log 0755,d /var/log 0751,' -i /usr/lib/tmpfiles.d/var.conf 
sed -e 's,f /var/log/wtmp 0664,f /var/log/wtmp 0640,' -i /usr/lib/tmpfiles.d/var.conf 
sed -e 's,f /var/log/lastlog 0664,f /var/log/lastlog 0640,' -i /usr/lib/tmpfiles.d/var.conf 
sed -e 's,f /var/log/btmp 0660,f /var/log/btmp 0640,' -i /usr/lib/tmpfiles.d/var.conf 
sed -e 's,z /var/log/journal 2755,z /var/log/journal 2750,' -i /usr/lib/tmpfiles.d/systemd.conf
sed -e 's,z /var/log/journal/%m 2755,z /var/log/journal/%m 2750,' -i /usr/lib/tmpfiles.d/systemd.conf
# Fin: HARDE-RHEL-241
echo "HARDE-RHEL-242 : S'assurer que logrotate est configuré"
cat >/etc/logrotate.d/wtmp<<EOF
# no packages own wtmp -- we'll rotate it here
/var/log/wtmp {
    missingok
    monthly
    create 0600 root utmp
    minsize 1M
    rotate 12
}
EOF
cat >/etc/logrotate.d/lastlog<<EOF
# no packages own lastlog -- we'll rotate it here
/var/log/lastlog {
    missingok
    monthly
    create 0600 root utmp
    minsize 1M
    rotate 12
}
EOF
cat >/etc/logrotate.d/btmp<<EOF
# no packages own btmp -- we'll rotate it here
/var/log/btmp {
    missingok
    monthly
    create 0600 root utmp
    rotate 12
}
EOF
# Fin: HARDE-RHEL-242
echo "HARDE-RHEL-243 : S'assurer que le paramètre SSH LogLevel est approprié"
if  ! grep -q -E '^LogLevel\s+(VERBOSE|INFO)' /etc/ssh/sshd_config ; then echo "LogLevel VERBOSE">> /etc/ssh/sshd_config; fi
# Fin: HARDE-RHEL-243
echo "HARDE-RHEL-244 : Durcissement et configuration du service syslog"

# Fin: HARDE-RHEL-244
echo "HARDE-RHEL-245 : Cloisonnement du service syslog par chroot"

# Fin: HARDE-RHEL-245
echo "HARDE-RHEL-246 : Cloisonnement du service syslog par conteneur"

# Fin: HARDE-RHEL-246
echo "HARDE-RHEL-247 : Journaux d'activité de service"

# Fin: HARDE-RHEL-247



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
