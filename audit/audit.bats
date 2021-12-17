#! /usr/local/bin/bats
# -*- mode: shell; coding: utf-8-unix -*-

load error.bash
load output.bash
load lang.bash
load audit-helpers.sh

@test "HARDE-RHEL-1 : Minimisation des services installés" {
    ps -fadeZ > "$HOME/audit-ps-`date +'%Y-%m-%d'`.txt"
}
@test "HARDE-RHEL-2 : Minimisation de la configuration" {
    skip "Pas d'audit automatisé pour HARDE-RHEL-2"
}
@test "HARDE-RHEL-3 : Principe de moindre privilège" {
    skip "Pas d'audit automatique pour HARDE-RHEL-3"
}
@test "HARDE-RHEL-4 : Utilisation des fonctions de contrôles d'accès" {
    skip "Pas d'audit automatique pour HARDE-RHEL-4"
}
@test "HARDE-RHEL-5 : Principe de défense en profondeur" {
    skip "Pas d'audit automatique pour HARDE-RHEL-5"
}
@test "HARDE-RHEL-6 : Cloisonnement des services réseaux" {
    skip "Pas d'audit automatique pour HARDE-RHEL-6"
}
@test "HARDE-RHEL-7 : Journalisation de l'activité des services" {
    skip "Pas d'audit automatique pour HARDE-RHEL-7"
}
@test "HARDE-RHEL-8 : Mises à jour régulières" {
    skip "Pas d'audit automatique pour HARDE-RHEL-8"
}
@test "HARDE-RHEL-9 : Configuration matérielle" {
    skip "Pas d'audit automatique pour HARDE-RHEL-9"
}
@test "HARDE-RHEL-10 : Architecture 32 et 64 bits" {
    run uname -m
    [ "$output" = "x86_64" ]
}
@test "HARDE-RHEL-11 : Désactiver les sytèmes de fichiers inutilisés" {
    for fs in cramfs freevxfs jffs2 hfs hfsplus squashfs crc-itu-t udf fat vfat;
    do
	    modprobe -n -v $fs | fgrep "install /bin/true" 
	    grep $fs /proc/modules | fail_if_output "Module loaded"
    done
}
@test "HARDE-RHEL-12 : Partition séparée pour /home" {
    is_a_partition /home
    run mount
    echo "$output" | grep  "on /home.*nodev" 
}
@test "HARDE-RHEL-13 : Options de montage nodev,nosuid,noexec pour /dev/shm" {
    run mount
    echo "$output" | grep -E '\s/dev/shm\s' | grep nodev | grep nosuid | grep noexec
}
@test "HARDE-RHEL-14 : Options de montage nodev,nosuid,noexec pour les points de montage temporaire" {
    skip "Pas d'audit automatique pour HARDE-RHEL-14"
}
@test "HARDE-RHEL-15 : S'assurer de la configuration de /tmp" {
    is_a_partition /tmp
    run mount
    echo "$output" | grep -E '\s/tmp\s' | grep nodev | grep nosuid | grep noexec 
}
@test "HARDE-RHEL-16 : Désactiver le stockage USB" {
    for fs in usb-storage;
    do
	    modprobe -n -v $fs | fgrep "install /bin/true" 
	    grep $fs /proc/modules | fail_if_output "Module loaded"
    done
}
@test "HARDE-RHEL-17 : S'assurer de la configuration de /var" {
    is_a_partition /var
    run mount
    echo "$output" | grep -E '\s/var\s' | grep nodev
}
@test "HARDE-RHEL-18 : S'assurer de la configuration de /var/tmp" {
    is_a_partition /var/tmp
    mount | grep -E '\s/var/tmp\s' | grep nodev | grep nosuid | grep noexec 
}
@test "HARDE-RHEL-19 : Partitionnement type" {
    skip "Pas d'audit automatique pour HARDE-RHEL-19"
}
@test "HARDE-RHEL-20 : Restrictions d'accès sur le dossier /boot" {
    is_a_partition /boot
    grep '/boot.*noauto' /etc/fstab
}
@test "HARDE-RHEL-21 : Installation de paquets réduite au strict nécessaire" {
    skip "Pas d'audit automatique pour HARDE-RHEL-21"
}
@test "HARDE-RHEL-22 : Choix des dépôts de paquets" {
    skip "Pas d'audit automatique pour HARDE-RHEL-22"
}
@test "HARDE-RHEL-23 : Dépôts de paquets durcis" {
    skip "Pas d'audit automatique pour HARDE-RHEL-23"
}
@test "HARDE-RHEL-24 : Robustesse du mot de passe administrateur" {
    skip "Pas d'audit automatique pour HARDE-RHEL-24"
}
@test "HARDE-RHEL-25 : Installation d'éléments secrets ou de confiance" {
    skip "Pas d'audit automatique pour HARDE-RHEL-25"
}
@test "HARDE-RHEL-26 : S'assurer que les politiques de chiffrement historiques soient désactivées" {
    run grep -E -i '^\s*LEGACY\s*(\s+#.*)?$' /etc/crypto-policies/config
    [ $status -eq 1 ]
}
@test "HARDE-RHEL-27 : S'assurer que le mode FIPS ou FUTURE est activé pour le chiffrement" {
    grep -E -i '^\s*(FUTURE|FIPS)\s*(\s+#.*)?$' /etc/crypto-policies/config
}
@test "HARDE-RHEL-28 : S'assurer que l'IP Forwarding est désactivé" {
    declare -a sysctls
    sysctls=(
	[0]="^\s*net\.ipv4\.ip_forward\s*=\s*1"
	[1]="^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1"
    )
    for regexp in "${sysctls[@]}"; do
	    grep -E -s $regexp /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf | fail_if_output
	done
}
@test "HARDE-RHEL-29 : Désactiver les ICMP Redirects" {
    declare -a sysctls
    sysctls=(
	[0]="^\s*net\.ipv4\.conf\.all\.send_redirects\s*=\s*0"
	[1]="^\s*net\.ipv4\.conf\.default\.send_redirects\s*=\s*0"
    )
    for regexp in "${sysctls[@]}"; do
	    grep -E -s $regexp /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf
	done
}
@test "HARDE-RHEL-30 : Refuser les paquets routés par la source" {
    declare -a sysctls
    sysctls=(
	[0]="^\s*net\.ipv4\.conf\.all\.accept_source_route\s*=\s*0"
	[1]="^\s*net\.ipv4\.conf\.default\.accept_source_route\s*=\s*0"
    )
    for regexp in "${sysctls[@]}"; do
	    grep -E -s $regexp /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf
    done
}
@test "HARDE-RHEL-31 : S'assurer que les paquets suspects soient loggués" {
    declare -a sysctls
    sysctls=(
	[0]="^\s*net\.ipv4\.conf\.all\.log_martians\s*=\s*1"
	[1]="^\s*net\.ipv4\.conf\.default\.log_martians\s*=\s*1"
    )
    for regexp in "${sysctls[@]}"; do
	    grep -E -s $regexp /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf
    done
}
@test "HARDE-RHEL-32 : Refuser les ICMP broadcast" {
    declare -a sysctls
    sysctls=(
	[0]="^\s*net\.ipv4\.icmp_echo_ignore_broadcasts\s*=\s*1"
    )
    for regexp in "${sysctls[@]}"; do
	    grep -E -s $regexp /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf
    done
}
@test "HARDE-RHEL-33 : Ignorer les réponses ICMP douteuses" {
    [ $(sysctl -n net.ipv4.icmp_ignore_bogus_error_responses) -eq 1 ]
    grep -E -s "^\s*net\.ipv4\.icmp_ignore_bogus_error_responses\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | fail_if_output
}
@test "HARDE-RHEL-34 : Activer le filtrage par routage inversé" {
    [ $(sysctl -n net.ipv4.conf.all.rp_filter) -eq 1 ]
    [ $(sysctl -n net.ipv4.conf.default.rp_filter) -eq 1 ] 
    grep -E -s "^\s*net\.ipv4\.conf\.all\.rp_filter\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | fail_if_output
    grep -E -s "^\s*net\.ipv4\.conf\.default\.rp_filter\s*=\s*0" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | fail_if_output
}
@test "HARDE-RHEL-35 : Activer les TCP Syn Cookies" {
    [ $(sysctl -n net.ipv4.tcp_syncookies) -eq 1 ]
    grep -E -r "^\s*net\.ipv4\.tcp_syncookies\s*=\s*[02]" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf | fail_if_output
}
@test "HARDE-RHEL-36 : Refuser les paquets IPv6 Router Advertisements" {
    skip "IPv6 est désactivé"
}
@test "HARDE-RHEL-37 : Désactiver IPV6" {
    grep -E "^\s*kernelopts=(\S+\s+)*ipv6\.disable=1\b\s*(\S+\s*)*$" /proc/cmdline
}
@test "HARDE-RHEL-38 : S'assurer que la politique de chiffrement système n'est pas outrepassée " {
    grep '^/s*CRYPTO_POLICY=' /etc/sysconfig/sshd | fail_if_output "System-crypto over-ridden"
}
@test "HARDE-RHEL-39 : Paramétrage des sysctl réseau" {
    skip "Pas d'audit automatique pour HARDE-RHEL-39"
}
@test "HARDE-RHEL-40 : Permissions des fichiers de configuration du démarrage" {
    # /boot may be not mounted
    if [ -d /boot/grub]; then
	    check_owner root /boot/grub2/grub/*
	    check_perm 0600 /boot/grub2/grub/*
    else
	    skip "Partition /boot non accessible."
    fi
}
@test "HARDE-RHEL-41 : Verrouiller par mot de passe la configuration de demarrage" {
    # /boot may be not mounted
    if [ -d /boot/grub]; then
	    grep "^\s*GRUB2_PASSWORD" /boot/grub2/user.cfg
    else
	    skip "Partition /boot non accessible."
    fi
}
@test "HARDE-RHEL-42 : Demander un mot de passe pour les modes de secours" {
    grep /systemd-sulogin-shell /usr/lib/systemd/system/rescue.service
    grep /systemd-sulogin-shell /usr/lib/systemd/system/emergency.service
}
@test "HARDE-RHEL-43 : Directive de configuration de l'IOMMU" {
    # /boot may be not mounted
    if [ -d /boot/grub]; then
	    grep iommu=force /boot/grub/menu.lst
    else
	    skip "Partition /boot non accessible."
    fi
}
@test "HARDE-RHEL-44 : Configurer la connexion Red Hat Subscription Manager" {
    skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-44"
}
@test "HARDE-RHEL-45 : Désactiver le démon rhnsd" {
    run systemctl is-enabled rhnsd
    [ $status = 1 ]
}
@test "HARDE-RHEL-46 : S'assurer que les clés PGP soient configurées" {
    rpm -q gpg-pubkey --qf '%{name}-%{version}-%{release} --> %{summary}\n'
}
@test "HARDE-RHEL-47 : Activer l'option gpgcheck" {
    grep ^gpgcheck /etc/yum.conf
    grep ^gpgcheck /etc/yum.repos.d/*
    grep -P '^\h*gpgcheck=[^1\n\r]+\b(\h+.*)?$' /etc/yum.conf /etc/yum.repos.d/*.repo | fail_if_output
}
@test "HARDE-RHEL-48 : S'assurer que les dépôts soient configurés" {
    dnf repolist
}
@test "HARDE-RHEL-49 : S'assurer que les mises à jour de sécurité sont installées" {
    dnf history
}
@test "HARDE-RHEL-50 : Activer le démon cron" {
    systemctl is-enabled crond
}
@test "HARDE-RHEL-51 : Services et démons résidents en mémoire" {
    skip "Pas de méthode d'audit automatique pour HARDE-RHEL-51"
}
@test "HARDE-RHEL-52 : Restriction des accès des services déployés" {
    skip "Pas d'audit automatique pour HARDE-RHEL-52"
}
@test "HARDE-RHEL-53 : Durcissement des composants de virtualisation" {
    skip "Pas d'audit automatique pour HARDE-RHEL-53"
}
@test "HARDE-RHEL-54 : Cage chroot et privilèges d'accès du service cloisonné" {
    skip "Pas d'audit automatique pour HARDE-RHEL-54"
}
@test "HARDE-RHEL-55 : Activation et utilisation de chroot par un service" {
    skip "Pas d'audit automatique pour HARDE-RHEL-55"
}
@test "HARDE-RHEL-56 : Ne pas installer xinetd" {
    run rpm -q xinetd
    [ ${status} = 1 ]
}
@test "HARDE-RHEL-57 : S'assurer que le serveur FTP est désactivé" {
    netstat -ln | grep -v 21
    skip "Pas d'audit automatique pour HARDE-RHEL-57"
}
@test "HARDE-RHEL-58 : S'assurer que le serveur DNS est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-58"
}
@test "HARDE-RHEL-59 : S'assurer que NFS est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-59"
}
@test "HARDE-RHEL-60 : S'assurer que RPC est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-60"
}
@test "HARDE-RHEL-61 : S'assurer que le serveur LDAP est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-61"
}
@test "HARDE-RHEL-62 : S'assurer que le serveur DHCP est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-62"
}
@test "HARDE-RHEL-63 : S'assurer que le serveur CUPS est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-63"
}
@test "HARDE-RHEL-64 : S'assurer que le serveur NIS est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-64"
}
@test "HARDE-RHEL-65 : S'assurer que l'agent de transfert de mail soit en mode local seulement" {
skip "Pas d'audit automatique pour HARDE-RHEL-65"
}
@test "HARDE-RHEL-66 : Désactiver le service rsyncd" {
    run systemctl is-enabled rsyncd

}
@test "HARDE-RHEL-67 : S'assurer que le serveur Avahi est désactivé" {
    run systemctl is-enabled avahi-daemon
    [ $status = 1 ]
}
@test "HARDE-RHEL-68 : S'assurer que le serveur SNMP est désactivé" {
    run systemctl is-enabled snmpd
    [ $status = 1 ]
}
@test "HARDE-RHEL-69 : S'assurer que le service Proxy HTTP est désactivé" {
    run systemctl is-enabled squid
    [ $status = 1 ]
}
@test "HARDE-RHEL-70 : S'assurer que le service Samba  est désactivé" {
    run systemctl is-enabled sm
    [ $status = 1 ]
}
@test "HARDE-RHEL-71 : S'assurer que le service IMAP/POP3 est désactivé" {
    run systemctl is-enabled dovecot
    [ $status = 1 ]
}
@test "HARDE-RHEL-72 : S'assurer que le serveur HTTP est désactivé" {
skip "Pas d'audit automatique pour HARDE-RHEL-72"
}
@test "HARDE-RHEL-73 : Désactiver les protocoles DDCP, SCTP, RDS et TIPC" {
skip "Pas d'audit automatique pour HARDE-RHEL-73"
}
@test "HARDE-RHEL-74 : Durcissement et surveillance des services soumis à des flux arbitraires" {
skip "Pas d'audit automatique pour HARDE-RHEL-74"
}
@test "HARDE-RHEL-75 : Configuration du service local de messagerie" {
skip "Pas d'audit automatique pour HARDE-RHEL-75"
}
@test "HARDE-RHEL-76 : Alias de messagerie des comptes de service" {
skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-76"
}
@test "HARDE-RHEL-77 : S'assurer que firewalld est installé" {
skip "Pas d'audit automatique pour HARDE-RHEL-77"
}
@test "HARDE-RHEL-78 : Activer le service firewalld" {
skip "Pas d'audit automatique pour HARDE-RHEL-78"
}
@test "HARDE-RHEL-79 : Désactiver iptables" {
skip "Pas d'audit automatique pour HARDE-RHEL-79"
}
@test "HARDE-RHEL-80 : Désactiver nftables" {
skip "Pas d'audit automatique pour HARDE-RHEL-80"
}
@test "HARDE-RHEL-81 : S'assurer qu'une zone par défaut est définie" {
skip "Pas d'audit automatique pour HARDE-RHEL-81"
}
@test "HARDE-RHEL-82 : S'assurer que les interfaces soient assignées à une zone" {
run nmcli -t connection show | awk -F: '{if($4){print $4}}' | while read INT; do firewall-cmd --get-active-zones | grep -B1 "${INT}"; done
}
@test "HARDE-RHEL-83 : Bloquer les services et ports inutiles" {
run firewall-cmd --get-active-zones | awk '!/:/ {print $1}' | while read ZN; do firewall-cmd --list-all --zone="${ZN}"; done
}
@test "HARDE-RHEL-84 : Configurer nftables" {
skip "Pas d'audit automatique pour HARDE-RHEL-84"
}
@test "HARDE-RHEL-85 : Configurer iptables" {
skip "Pas d'audit automatique pour HARDE-RHEL-85"
}
@test "HARDE-RHEL-86 : Désactiver les interfaces sans fil" {
skip "Pas d'audit automatique pour HARDE-RHEL-86"
}
@test "HARDE-RHEL-87 : Activation de SELinux avec la politique targeted" {
    rpm -q libselinux
    sestatus | grep "SELinux status" | grep enabled
    # Ne doit rien retourner, FIXME UEFI
    if [ -d /boot/grub ]; then
        grep -E 'kernelopts=(\S+\s+)*(selinux=0|enforcing=0)+\b' /boot/grub2/grubenv \
        | fail_if_output
    fi
    # Doit retourner targeted
    grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config
    # Ne doit rien retourner
    ps -eZ | grep unconfined_service_t | fail_if_output
}
@test "HARDE-RHEL-88 : Désinstallation des outils de débogage de politique SELinux" {
    run rpm -q settroubleshoot
    [ ${status} = 1 ]
    run rpm -q mcstrans
    [ ${status} = 1 ]
}
@test "HARDE-RHEL-89 : S'assurer que at/cron est restreint aux utilisateurs autorisés" {
    [ ! -e  /etc/cron.deny ]
    [ ! -e  /etc/at.deny ]
    check_owner root /etc/cron.allow
    check_perm 0600 /etc/cron.allow
    check_owner root /etc/at.allow
    check_perm 0600 /etc/at.allow
}
@test "HARDE-RHEL-90 : S'assurer que l'accès SSH soit limité" {
    grep -E '^\s*(Allow|Deny)(Users|Groups)\s+\S+' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-91 : S'assurer que l'accès à la commande su est limité" {
    grep pam_wheel.so /etc/pam.d/su
}
@test "HARDE-RHEL-92 : S'assurer de l'intégrité de la variable PATH pour root" {
for x in $(echo $PATH | tr ":" " ") ; do
    if [ -d "$x" ] ; then
        ls -ldH "$x" | awk '$9 == "." {print "PATH contains current working directory (.)"} $3 != "root" {print $9, "is not owned by root"} substr($1,6,1) != "-" {print $9, "is group writable"} substr($1,9,1) != "-" {print $9, "is world writable"}'
    else
        echo "$x is not a directory or does not exist"
    fi
done
}
@test "HARDE-RHEL-93 : Imputabilité des opérations d'administration" {
    skip "Méthode d'audit à implémenter pour HARDE-RHEL-93"
}
@test "HARDE-RHEL-94 : Répertoires temporaires dédiés aux comptes" {
    grep -E '^[^#]*pam_namespace' /etc/pam.d/*
}
@test "HARDE-RHEL-95 : Activation des profils de sécurité AppArmor" {
    skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-95"
}
@test "HARDE-RHEL-96 : Paramétrage des booléens SELinux" {
    getsebool selinuxuser_execheap | grep off
    getsebool deny_execmem | grep on
    getsebool selinuxuser_execstack | grep off
    getsebool selinuxuser_execmod | grep off
    getsebool secure_mode_insmod | grep on
    skip ssh_sysadm_login est recommandé à non mais peut être positionné à oui en fonction de la politique.
}
@test "HARDE-RHEL-97 : Confinement des utilisateurs interactifs non privilégiés" {
    skip "Pas d'audit automatique pour HARDE-RHEL-97"
}
@test "HARDE-RHEL-98 : Utiliser une source de temps" {
    rpm -q chrony
}
@test "HARDE-RHEL-99 : S'assurer que chrony est configuré" {
    grep -E "^(server|pool)" /etc/chrony.conf
}
@test "HARDE-RHEL-100 : Service autofs désactivé" {
    run systemctl is-enabled autofs
    [ $status = 1 ]
}
@test "HARDE-RHEL-101 : Supprimer le serveur X" {
    rpm -qa xorg-x11* | fail_if_output
}
@test "HARDE-RHEL-102 : S'assurer que le client NIS n'est pas installé" {
    run rpm -q ypbind
    [ $status = 1 ]
}
@test "HARDE-RHEL-103 : S'assurer que le client telnet n'est pas installé" {
    run rpm -q telnet
    [ $status = 1 ]
}
@test "HARDE-RHEL-104 : S'assurer que le client ldap n'est pas installé" {
    skip "Le client LDAP peut être requis dans certains cas"
}
@test "HARDE-RHEL-105 : S'assurer que le paramètre SSH AllowTcpForwarding est désactivé" {
    grep -E '^AllowTcpForwarding\s+no' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-106 : S'assurer que le transfert X11 SSH est désactivé" {
    grep -E '^X11Forwarding\s+no' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-107 : Installer sudo" {
    rpm -q sudo
}
@test "HARDE-RHEL-108 : S'assurer que les commandes sudo utilisent un pseudo-TTY et autres directives" {
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?noexec' /etc/sudoers /etc/sudoers.d/*
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?requiretty' /etc/sudoers /etc/sudoers.d/*
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?use_pty' /etc/sudoers /etc/sudoers.d/*
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?umask=0027' /etc/sudoers /etc/sudoers.d/*
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?ignore_dot' /etc/sudoers /etc/sudoers.d/*
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?env_reset' /etc/sudoers /etc/sudoers.d/*
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?passwd_timeout=1' /etc/sudoers /etc/sudoers.d/*
}
@test "HARDE-RHEL-109 : Afficher des bannières lors de la connexion" {
    skip "Pas d'audit automatique pour HARDE-RHEL-109"
}
@test "HARDE-RHEL-110 : S'assurer que le paramètre SSH root login est désactivé" {
    grep -E '^PermitRootLogin\s+no' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-111 : S'assurer que le paramètre SSH PermitEmptyPasswords est désactivé" {
    grep -E '^PermitEmptyPasswords\s+no' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-112 : S'assurer que le paramètre SSH PermitUserEnvironment est désactivé" {
    grep -E '^PermitUserEnvironment\s+no' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-113 : S'assurer que le paramètre SSH Idle Timeout Interval est configuré" {
run grep ^Client /etc/ssh/sshd_config
}
@test "HARDE-RHEL-114 : S'assurer que le paramètre SSH LoginGraceTime est positionné à une minute ou moins" {
run grep ^LoginGraceTime /etc/ssh/sshd_config
}
@test "HARDE-RHEL-115 : S'assurer que la bannière SSH est configurée" {
run grep ^Banner /etc/ssh/sshd_config
}
@test "HARDE-RHEL-116 : S'assurer que le paramètrage SSH PAM est activé" {
run grep ^UsePAM /etc/ssh/sshd_config
}
@test "HARDE-RHEL-117 : S'assurer que le paramètre SSH MaxStartups est configuré" {
run grep ^MaxStartups /etc/ssh/sshd_config
}
@test "HARDE-RHEL-118 : S'assurer que le paramètre SSH MaxSessions est positionné à 4 ou moins" {
run grep ^MaxSessions /etc/ssh/sshd_config
}
@test "HARDE-RHEL-119 : S'assurer que le paramètre SSH MaxAuthTries est positionné à 4 ou moins" {
run grep -E 'MaxAuthTries\s+[0-9]' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-120 : S'assurer que le paramètre SSH IgnoreRhosts est activé" {
run grep -E '^IgnoreRhosts\s+yes' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-121 : S'assurer que le paramètre SSH HostbasedAuthentication est désactivé" {
run grep -E '^HostbasedAuthentication\s+no' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-122 : Créer un profil authselect personnalisé" {
    skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-122"
}
@test "HARDE-RHEL-123 : Selectionner le profil authselect" {
    skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-123"
}
@test "HARDE-RHEL-124 : S'assurer que le paramètrage authselect inclus with-faillock" {
    skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-124"
}
@test "HARDE-RHEL-125 : S'assurer que les exigences de création de mot de passe soient correctes" {
    grep pam_pwquality.so /etc/pam.d/system-auth /etc/pam.d/password-auth
    grep ^minlen /etc/security/pwquality.conf
    grep ^minclass /etc/security/pwquality.conf
}
@test "HARDE-RHEL-126 : S'assurer que le verrouillage après des tentatives de connexion soit configuré" {
    grep -E '^\s*auth\s+required\s+pam_faillock.so\s+' /etc/pam.d/password-auth /etc/pam.d/system-auth
}
@test "HARDE-RHEL-127 : S'assurer que la réutilisation d'anciens mots de passe soit limitée" {
run grep -E '^\s*password\s+(requisite|sufficient)\s+(pam_pwhistory\.so|pam_unix\.so)\s+.*remember=([5-9]|[1-4][0-9])[0-9]*\s*.*$' /etc/pam.d/system-auth
}
@test "HARDE-RHEL-128 : Protection des mots de passe stockés" {
    declare -a pw_files
    pw_files=(
        [0]="/etc/login.defs"
        [1]="/etc/pam.d/system-auth"
        [2]="/etc/pam.d/password-auth"
    )
    for f in "${pw_files[@]}"; do
        grep -i sha512 $f
        grep -i rounds $f
    done
}
@test "HARDE-RHEL-129 : S'assurer que l'expiration des mots de passe soit de 365 jours ou moins" {
    grep PASS_MAX_DAYS /etc/login.defs
    # FIXME
    grep -E '^[^:]+:[^!*]' /etc/shadow | cut -d: -f1,5
}
@test "HARDE-RHEL-130 : S'assurer que le nombre minimum de jours entre 2 changements de mot de passe soit 7 ou plus" {
    grep PASS_MIN_DAYS /etc/login.defs
    # FIXME
    grep -E '^[^:]+:[^!*]' /etc/shadow | cut -d: -f1,5
}
@test "HARDE-RHEL-131 : S'assurer que l'alerte pour expiration de mot de passe soit émise 7 jours ou plus avant expiration du mot de passe" {
    grep PASS_WARN_AGE /etc/login.defs
    # FIXME outputs account:warning
    grep -E ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1,6
}
@test "HARDE-RHEL-132 : S'assurer que le verrouillage des comptes inutilisés soit de 30 jours ou moins" {
    useradd -D | grep INACTIVE=-1 | fail_if_output
    # FIXME checks days is 30 OR LESS
    useradd -D | grep INACTIVE=30
}
@test "HARDE-RHEL-133 : S'assurer que toutes les dates de changement de mot de passe sont dans le passé" {
    PATH=/sbin:$PATH awk -F: '($1!="root" && $1!="sync" && $1!="shutdown" && $1!="halt" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!="'"$(which nologin)"'" && $7!="/bin/false") {print}' /etc/passwd
awk -F: '($1!="root" && $1!~/^\+/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}' | fail_if_output
}
@test "HARDE-RHEL-134 : S'assurer que les comptes système soient sécurisés" {
    skip "Pas d'audit automatique pour HARDE-RHEL-134"
}
@test "HARDE-RHEL-135 : S'assurer que la temporisation par défaut des shell utilisateurs soit de 900 secondes ou moins" {
    grep "^readonly TMOUT" /etc/profile /etc/profile.d/*.sh 
}
@test "HARDE-RHEL-136 : S'assurer que le groupe par défaut du compte root est 0" {
    skip "Pas d'audit automatique pour HARDE-RHEL-136"
}
@test "HARDE-RHEL-137 : S'assurer que la connexion est root est seulement possible sur la console system" {
    [ -e /etc/securetty ]
    AUTH_FILES=(
        [0]="/etc/pam.d/system-auth"
        [1]="/etc/pam.d/password-auth"
    )
    for pamFile in "${AUTH_FILES[@]}" ; do
        grep "pam_securetty.so noconsole" $pamFile
    done
}
@test "HARDE-RHEL-138 : S'assurer qu'aucun mot de passe n'est vide" {
    awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow | fail_if_output "Des comptes sans mot de passe existent"
}
@test "HARDE-RHEL-139 : S'assurer que qu'aucune entrée dans /etc/passwd n'utilise le code historique "+" " {
    grep '^\+:' /etc/passwd | fail_if_output
}
@test "HARDE-RHEL-140 : S'assurer que qu'aucune entrée dans /etc/shadow n'utilise le code historique "+" " {
    grep '^\+:' /etc/shadow | fail_if_output
}
@test "HARDE-RHEL-141 : S'assurer que qu'aucune entrée dans /etc/group n'utilise le code historique "+" " {
    grep '^\+:' /etc/group | fail_if_output
}
@test "HARDE-RHEL-142 : S'assurer que root est le seul compte avec UID 0" {
    awk -F: '($3 == 0) { print $1 }' /etc/passwd | grep -v root | fail_if_output
}
@test "HARDE-RHEL-143 : Désactivation des comptes utilisateurs inutilisés" {
    skip "Pas d'audit automatique pour HARDE-RHEL-143"
}
@test "HARDE-RHEL-144 : Désactivation des comptes de services" {
        skip "Pas d'audit automatique pour HARDE-RHEL-144"
}
@test "HARDE-RHEL-145 : Unicité et exclusivité des comptes de services" {
    skip "Pas d'audit automatique pour HARDE-RHEL-145"
}
@test "HARDE-RHEL-146 : Délai d'expiration de sessions utilisateurs" {
    skip "Pas d'audit automatique pour HARDE-RHEL-146"
}
@test "HARDE-RHEL-147 : Applications utilisant PAM" {
    skip "Pas d'audit automatique pour HARDE-RHEL-147"
}
@test "HARDE-RHEL-148 : Sécurisation des services réseau d'authentification PAM" {
    skip "Pas d'audit automatique pour HARDE-RHEL-148"
}
@test "HARDE-RHEL-149 : Sécurisation des accès aux bases utilisateurs distantes" {
    skip "Pas d'audit automatique pour HARDE-RHEL-149"
}
@test "HARDE-RHEL-150 : Séparation des comptes système et d'administrateur de l'annuaire" {
    skip "Pas d'audit automatique pour HARDE-RHEL-150"
}
@test "HARDE-RHEL-151 : Groupe dédié à l'usage de sudo" {
    check_group sudogrp /usr/bin/sudo
    check_owner root /usr/bin/sudo
    check_perm 4110 /usr/bin/sudo
}
@test "HARDE-RHEL-152 : Authentification des utilisateurs exécutant sudo" {
    grep -v -E '^#' /etc/sudoers | grep NOPASSWD | fail_if_output
}
@test "HARDE-RHEL-153 : Privilèges des utilisateurs cibles pour une commande sudo" {
    skip "Dépendant des services"
}
@test "HARDE-RHEL-154 : Limitation du nombre de commandes nécessitant l'option EXEC" {
    #Vérifier la présence de l'option EXEC sur les commandes permettant de lancer d'autres shells/commandes.
    skip "Pas d'audit automatique pour HARDE-RHEL-154"
}
@test "HARDE-RHEL-155 : Du bon usage de la négation dans une spécification sudo" {
     grep -v -E '(^Defaults|^#|^$)' /etc/sudoers /etc/sudoers.d/*| grep -v '^#' | fgrep \! | fail_if_output
}
@test "HARDE-RHEL-156 : Arguments explicites dans les spécifications sudo" {
    skip "Pas d'audit automatique pour HARDE-RHEL-156"
}
@test "HARDE-RHEL-157 : Du bon usage de sudoedit" {
    skip "Pas d'audit automatique pour HARDE-RHEL-157"
}
@test "HARDE-RHEL-158 : Sticky bit et droits d'accès en écriture" {
    # Lister les répertoires modifiables par tous et sans sticky bit
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a \! -perm -1000 \) -ls | fail_if_output 
    # Lister les répertoires modifiables par tous et n’appartenant pas à root
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d -perm -0002 -a \! -uid 0 -ls | fail_if_output 
}
@test "HARDE-RHEL-159 : Installer AIDE" {
    rpm -q aide
}
@test "HARDE-RHEL-160 : Vérification régulière de l'intégrité de système de fichiers" {
    grep 'ExecStart=/usr/sbin/aide --check' /etc/systemd/system/aidecheck.service
    systemctl is-enabled aidecheck.timer
    systemctl status aidecheck.timer
}
@test "HARDE-RHEL-161 : S'assurer que les permissions sur /etc/crontab soient correctes" {
    check_owner root /etc/crontab
    check_perm 0600 /etc/crontab
}
@test "HARDE-RHEL-162 : S'assurer que les permissions sur /etc/cron.hourly soient correctes" {
    check_owner root /etc/cron.hourly
    check_perm 0700 /etc/cron.hourly
}
@test "HARDE-RHEL-163 : S'assurer que les permissions sur /etc/cron.daily soient correctes" {
    check_owner root /etc/cron.daily
    check_perm 0700 /etc/cron.daily
}
@test "HARDE-RHEL-164 : S'assurer que les permissions sur /etc/cron.weekly soient correctes" {
    check_owner root /etc/cron.weekly
    check_perm 0700 /etc/cron.weekly
}
@test "HARDE-RHEL-165 : S'assurer que les permissions sur /etc/cron.monthly soient correctes" {
    check_owner root /etc/cron.monthly
    check_perm 0700 /etc/cron.monthly
}
@test "HARDE-RHEL-166 : S'assurer que les permissions sur /etc/cron.d soient correctes" {
    check_owner root /etc/cron.d
    check_perm 0700 /etc/cron.d
}
@test "HARDE-RHEL-167 : S'assurer que les permissions sur /etc/ssh/sshd_config soient correctes" {
    check_owner root /etc/ssh/sshd_config
    check_perm 0600 /etc/ssh/sshd_config
}
@test "HARDE-RHEL-168 : S'assurer que les permissions sur les clés privées d'hôte SSH soient correctes" {
    check_owner root /etc/ssh/ssh_host_*_key
    check_perm 0600 /etc/ssh/ssh_host_*_key
}
@test "HARDE-RHEL-169 : S'assurer que les permissions sur les clés publiques d'hôte soient correctes" {
    check_owner root /etc/ssh/ssh_host_*_key.pub
    check_perm 0644 /etc/ssh/ssh_host_*_key.pub
}
@test "HARDE-RHEL-170 : S'assurer que l'umask utilisateur est ou plus restrictif" {
    grep "umask 027" /etc/bashrc
    # /etc/profile.d/*.sh overrides /etc/profile    
    grep "umask" /etc/profile /etc/profile.d/*.sh
}
@test "HARDE-RHEL-171 : Auditer les permissions du système de fichiers" {
    rpm -Va --nomtime --nosize --nomd5 --nolinkto || true > "$HOME/audit-rpm-`date +'%Y-%m-%d'`.txt"
}
@test "HARDE-RHEL-172 : S'assurer qu'aucun fichier en écriture pour tout le monde n'existe" {
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | fail_if_output
}
@test "HARDE-RHEL-173 : S'assurer que tous les fichiers ont un propriétaire" {
    df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser | fail_if_output
}
@test "HARDE-RHEL-174 : S'assurer que tous les fichiers ont un groupe" {
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup | fail_if_output
}
@test "HARDE-RHEL-175 : Auditer les exécutables SUID" {
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 -ls > "$HOME/audit-suid-$(date +'%Y-%m-%d').txt"
}
@test "HARDE-RHEL-176 : Auditer les exécutables SGID" {
    df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 -ls > "$HOME/audit-sgid-$(date +'%Y-%m-%d').txt"
}
@test "HARDE-RHEL-177 : S'assurer que les permissions sur /etc/passwd soient correctes" {
    check_owner root /etc/passwd
    check_group root /etc/passwd
    check_perm 0644 /etc/passwd
}
@test "HARDE-RHEL-178 : S'assurer que les permissions sur /etc/shadow soient correctes" {
    check_owner root /etc/shadow
    # In RHEL 8.2 or older the group may be shadow
    check_group root /etc/shadow
    check_perm 0640 /etc/shadow
}
@test "HARDE-RHEL-179 : S'assurer que les permissions sur /etc/group soient correctes" {
    check_owner root /etc/group
    check_group root /etc/group
    check_perm 0644 /etc/group
}
@test "HARDE-RHEL-180 : S'assurer que les permissions sur /etc/gshadow soient correctes" {
    check_owner root /etc/gshadow
    check_group root /etc/gshadow
    check_perm 0640 /etc/gshadow
}
@test "HARDE-RHEL-181 : S'assurer que les permissions sur /etc/passwd- soient correctes" {
    check_owner root /etc/passwd-
    check_group root /etc/passwd-
    check_perm_from_file /etc/passwd /etc/passwd-
}
@test "HARDE-RHEL-182 : S'assurer que les permissions sur /etc/shadow- soient correctes" {
    check_owner root /etc/shadow-
    check_group root /etc/shadow-
    check_perm_from_file /etc/shadow /etc/shadow-
}
@test "HARDE-RHEL-183 : S'assurer que les permissions sur /etc/group- soient correctes" {
    check_owner root /etc/group-
    check_group root /etc/group-
    check_perm_from_file /etc/group /etc/group-
}
@test "HARDE-RHEL-184 : S'assurer que les permissions sur /etc/gshadow- soient correctes" {
    check_owner root /etc/gshadow-
    check_group root /etc/gshadow-
    check_perm_from_file /etc/gshadow /etc/gshadow-
}
@test "HARDE-RHEL-185 : S'assurer que les utilisateurs n'ont pas de fichier .forward" {
PATH=/sbin:$PATH grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 !="'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then echo ".forward file $dir/.forward exists"; fi; fi; done
}
@test "HARDE-RHEL-186 : S'assurer que les utilisateurs n'ont pas de fichier .netrc" {
PATH=/sbin:$PATH grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 !="'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then echo ".netrc file $dir/.netrc exists"; fi; fi; done
}
@test "HARDE-RHEL-187 : S'assurer que les fichiers .netrc ne soint pas accessibles en écriture" {
PATH=/sbin:$PATH grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 !="'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else for file in $dir/.netrc; do if [ ! -h "$file" -a -f "$file" ]; then fileperm=$(ls -ld $file | cut -f1 -d" "); if [ $(echo $fileperm | cut -c5) != "-" ]; then echo "Group Read set on $file"; fi; if [ $(echo $fileperm | cut -c6) != "-" ]; then echo "Group Write set on $file"; fi; if [ $(echo $fileperm | cut -c7) != "-" ]; then echo "Group Execute set on $file"; fi; if [ $(echo $fileperm | cut -c8) != "-" ]; then echo "Other Read set on $file"; fi; if [ $(echo $fileperm | cut -c9) != "-" ]; then echo "Other Write set on $file"; fi; if [ $(echo $fileperm | cut -c10) != "-" ]; then echo "Other Execute set on $file"; fi; fi; done; fi; done
}
@test "HARDE-RHEL-188 : S'assurer qu'il n'existe pas de fichier .rhosts" {
PATH=/sbin:$PATH grep -E -v '^(root|halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else for file in $dir/.rhosts; do if [ ! -h "$file" -a -f "$file" ]; then echo ".rhosts file in $dir"; fi; done; fi; done
}
@test "HARDE-RHEL-189 : S'assurer que tous les groupes de /etc/passwd existent dans /etc/group" {
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do grep -q -P "^.*?:[^:]*:$i:" /etc/group; if [ $? -ne 0 ]; then echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"; fi; done
}
@test "HARDE-RHEL-190 : S'assurer qu'il n'y a pas d'UIDs dupliqués" {
    cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do 
        [ -z "$x" ] && break; set - $x; if [ $1 -gt 1 ]; then users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs); echo "Duplicate UID ($2): $users"; fi
    done
}
@test "HARDE-RHEL-191 : S'assurer qu'il n'y a pas de GIDs dupliqués" {
    cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
	echo "Duplicate GID ($x) in /etc/group";
	exit 1
    done
}
@test "HARDE-RHEL-192 : S'assurer qu'il n'y a pas de de doublons dans les noms d'utilisateur" {
    cut -d: -f1 /etc/passwd | sort | uniq -d | while read x; do
	echo "Duplicate login name ${x} in /etc/passwd";
	exit 1
    done
}
@test "HARDE-RHEL-193 : S'assurer que qu'il n'y a pas de de doublons dans les noms de groupe" {
    cut -d: -f1 /etc/group | sort | uniq -d | while read x; do
	echo "Duplicate group name ${x} in /etc/group";
	exit 1
    done
}
@test "HARDE-RHEL-194 : S'assurer qu'il n'y a pas de groupe shadow" {
    grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group | fail_if_output
}
@test "HARDE-RHEL-195 : Vérifier que tous les utilisateurs aient un répertoire d'accueil" {
run  grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; fi; done
}
@test "HARDE-RHEL-196 : S'assurer que les permissions sur les répertoire d'accueil des utilisateurs soit 750 ou plus restrictif" {
run PATH=/sbin:$PATH grep -E -v '^(halt|sync|shutdown|nobody)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else dirperm=$(ls -ld $dir | cut -f1 -d" "); if [ $(echo $dirperm | cut -c6) != "-" ]; then echo "Group Write permission set on the home directory ($dir) of user $user"; fi; if [ $(echo $dirperm | cut -c8) != "-" ]; then echo "Other Read permission set on the home directory ($dir) of user $user"; fi; if [ $(echo $dirperm | cut -c9) != "-" ]; then echo "Other Write permission set on the home directory ($dir) of user $user"; fi; if [ $(echo $dirperm | cut -c10) != "-" ]; then echo "Other Execute permission set on the home directory ($dir) of user $user"; fi; fi; done
}
@test "HARDE-RHEL-197 : S'assurer que les utilisateurs possèdent leurs répertoires d'accueil" {
run PATH=/sbin:$PATH grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else owner=$(stat -L -c "%U" "$dir"); if [ "$owner" != "$user" ]; then echo "The home directory ($dir) of user $user is owned by $owner."; fi; fi; done
}
@test "HARDE-RHEL-198 : S'assurer que les fichiers de configuration des utilisateurs ne soient pas ouverts en écriture au groupe ou à tout le monde" {
run PATH=/sbin:$PATH grep -E -v '^(halt|sync|shutdown)' /etc/passwd | awk -F: '($7 != "'"$(which nologin)"'" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else for file in $dir/.[A-Za-z0-9]*; do if [ ! -h "$file" -a -f "$file" ]; then fileperm=$(ls -ld $file | cut -f1 -d" "); if [ $(echo $fileperm | cut -c6) != "-" ]; then echo "Group Write permission set on file $file"; fi; if [ $(echo $fileperm | cut -c9) != "-" ]; then echo "Other Write permission set on file $file"; fi; fi; done; fi; done
}
@test "HARDE-RHEL-199 : Droits d'accès aux fichiers de contenu sensible" {
    skip "Liste à définir"
}
@test "HARDE-RHEL-200 : Sécurisation des accès pour les sockets et pipes" {
    # make sure there is some form of access control, store result for later review
    echo "# Please review the generated report $HOME/audit-ss-`date +'%Y-%m-%d'`.txt"
    ls -alZ "$(ss -xp | grep / | sed -E -e 's/^[^\/]*(\/[^ ]*).*/\1/')" || true > "$HOME/audit-ss-`date +'%Y-%m-%d'`.txt"
}
@test "HARDE-RHEL-201 : Protection de la base de données des scellés" {
skip "Pas d'audit automatique pour HARDE-RHEL-201"
}
@test "HARDE-RHEL-202 : Désactiver la création de core dumps" {
    grep "hard core 0" /etc/security/limits.conf /etc/security/limits.d/*
    # sysctl fs.suid_dumpable
    [ $(sysctl -n fs.suid_dumpable ) -eq 0 ];
    grep -E 'fs\.suid_dumpable\s*=\s*0' /etc/sysctl.conf /etc/sysctl.d/*
}
@test "HARDE-RHEL-203 : Activer l'aléatoire dans l'organisation de l'espace d'adressage" {
    [ $(sysctl -n kernel.randomize_va_space ) -eq 2 ];
    grep -E 'kernel\.randomize_va_space\s*=\s*2' /etc/sysctl.conf /etc/sysctl.d/*
}
@test "HARDE-RHEL-204 : Paramètrage des sysctl système" {
    skip "Pas d'audit automatique pour HARDE-RHEL-204"
}
@test "HARDE-RHEL-205 : Désactivation du chargement des modules noyau" {
    [ $(sysctl -n kernel.modules_disabled) -eq 1 ];
}
@test "HARDE-RHEL-206 : Configuration sysctl du module Yama" {
    [ $(sysctl -n kernel.yama.ptrace_scope) -eq 1 ];
}
@test "HARDE-RHEL-207 : Partition séparée pour /var/log" {
    is_a_partition /var/log
    #grep -E '\s/var/log\s' /etc/fstab | grep -E -v '^\s*#'
}
@test "HARDE-RHEL-208 : Partition séparée pour /var/log/audit" {
    is_a_partition /var/log/audit
    # grep -E '\s/var/log/audit\s' /etc/fstab | grep -E -v '^\s*#'
}
@test "HARDE-RHEL-209 : Journal spécifique pour sudo" {
    grep -Ei '^\s*Defaults\s+([^#]+,\s*)?logfile=' /etc/sudoers /etc/sudoers.d/*
}
@test "HARDE-RHEL-210 : S'assurer qu'auditd est installé" {
    rpm -q audit audit-libs
}
@test "HARDE-RHEL-211 : S'assurer que le service auditd est activé" {
    systemctl is-enabled auditd
}
@test "HARDE-RHEL-212 : S'assurer que l'audit commence au plus tôt" {
    grep -E '\sauditd=1' /proc/cmdline
}
@test "HARDE-RHEL-213 : S'assurer que la valeur d'audit_backlog_limit est suffisante" {
    grep -E '\saudit_backlog_limit=[0-9]+' /proc/cmdline
}
@test "HARDE-RHEL-214 : Tracer les tentatives d'accès aux fichiers refusées " {
    grep access /etc/audit/rules.d/*.rules
    auditctl -l | grep access
}
@test "HARDE-RHEL-215 : Tracer les modifications d'utilisateurs" {
    grep identity /etc/audit/rules.d/*.rules
    auditctl -l | grep identity
}
@test "HARDE-RHEL-216 : Journalisation de l'activité par auditd" {
    auditctl -s | grep -q -E '^pid [^0]+';
    rules=$(auditctl -l | wc -l)
    [ ${rules} -gt 5 ]
}
@test "HARDE-RHEL-217 : Tracer l'utilisation des commandes privilégiés" {
run find / /usr /srv -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>='"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' -F auid!=4294967295 -k privileged" }' 
}
@test "HARDE-RHEL-218 : Tracer les suppressions de fichiers" {
run # grep delete /etc/audit/rules.d/*.rules
# auditctl -l | grep delete
}
@test "HARDE-RHEL-219 : Tracer le chargement/déchargement de modules" {
run # grep modules /etc/audit/rules.d/*.rules
# auditctl -l | grep modules
}
@test "HARDE-RHEL-220 : Tracer les actions des administrateurs" {
run # grep -E "^\s*-w\s+$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//')\s+-p\s+wa\s+-k\s+actions" /etc/audit/rules.d/*.rules
# auditctl -l | grep actions

}
@test "HARDE-RHEL-221 : S'assurer que la configuration auditd n'est pas modifiable" {
    grep "^\s*[^#]e\s2" /etc/audit/rules.d/*.rules | tail -1
}
@test "HARDE-RHEL-222 : S'assurer que la taille de stockage est spécifiée" {
    grep max_log_file /etc/audit/auditd.conf
}
@test "HARDE-RHEL-223 : S'assurer que les logs d'audit ne soient pas purgés" {
    grep max_log_file_action /etc/audit/auditd.conf | grep keep_log
}
@test "HARDE-RHEL-224 : S'assurer que le système s'arrête si le système d'audit est plein" {
    grep scope /etc/audit/rules.d/*.rules
}
@test "HARDE-RHEL-225 : Auditer tout changement du fichier sudoers" {
    skip "Pas d'audit automatique pour HARDE-RHEL-225"
}
@test "HARDE-RHEL-226 : Auditer toute connexion/déconnexion" {
    grep logins /etc/audit/rules.d/*.rules
    auditctl -l | grep logins
}
@test "HARDE-RHEL-227 : Collecter toutes les informations de session" {
    grep -E '(session|logins)' /etc/audit/rules.d/*.rules
    auditctl -l | grep -E '(session|logins)'
}
@test "HARDE-RHEL-228 : S'assurer que les évenement de changements horaires soient tracés" {
    grep time-change /etc/audit/rules.d/*.rules
    auditctl -l | grep time-change
}
@test "HARDE-RHEL-229 : S'assurer que les événements modifiant les MAC soient collectéees" {
    grep MAC-policy /etc/audit/rules.d/*.rules
    auditctl -l | grep MAC-policy
}
@test "HARDE-RHEL-230 : Tracer les événements changeant l'environnement réseau" {
    grep system-locale /etc/audit/rules.d/*.rules
    auditctl -l | grep system-locale
}
@test "HARDE-RHEL-231 : Tracer les changements de permission" {
    grep perm_mod /etc/audit/rules.d/*.rules
    auditctl -l | grep perm_mod
}
@test "HARDE-RHEL-232 : Installer le service rsyslog" {
    rpm -q rsyslog
}
@test "HARDE-RHEL-233 : Activer le service syslog" {
    systemctl is-enabled rsyslog
}
@test "HARDE-RHEL-234 : Configurer les permissions des fichiers journaux" {
    grep -E '^\$FileCreateMode\s+0640' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
}
@test "HARDE-RHEL-235 : Définir les fichiers journaux" {
    skip "Pas d'audit automatique pour HARDE-RHEL-235"
}
@test "HARDE-RHEL-236 : Renvoyer les journaux vers un hôte distant" {
    grep "^*.*[^I][^I]*@" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
}
@test "HARDE-RHEL-237 : S'assurer que seuls les puits de logs peuvent recevoir des logs" {
    skip "Pas de méthode d'audit pour la règle non implémentée HARDE-RHEL-237."
}
@test "HARDE-RHEL-238 : S'assurer que journald est redirigé vers rsyslog" {
    grep -e ^\s*ForwardToSyslog=yes /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*.conf
}
@test "HARDE-RHEL-239 : S'assurer que journald compresse les journaux de grande taille" {
    grep -e ^\s*Compress=yes /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*
}
@test "HARDE-RHEL-240 : S'assurer que journald écrit les journaux sur disque" {
    grep -e ^\s*Storage=persistent /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*
}
@test "HARDE-RHEL-241 : S'assurer de la permission des fichiers journaux" {
    find /var/log -type f -perm /037 -ls -o -type d -perm /026 -ls | fail_if_output "Incorrect permissions on these files"
}
@test "HARDE-RHEL-242 : S'assurer que logrotate est configuré" {
    skip "À réaliser manuellement en fonction du fichier journal."
}
@test "HARDE-RHEL-243 : S'assurer que le paramètre SSH LogLevel est approprié" {
    grep -E '^LogLevel\s+(VERBOSE|INFO)' /etc/ssh/sshd_config
}
@test "HARDE-RHEL-244 : Durcissement et configuration du service syslog" {
    skip "Pas d'audit automatique pour HARDE-RHEL-244"
}
@test "HARDE-RHEL-245 : Cloisonnement du service syslog par chroot" {
    skip "Pas d'audit automatique pour HARDE-RHEL-245"
}
@test "HARDE-RHEL-246 : Cloisonnement du service syslog par conteneur" {
    skip "Pas d'audit automatique pour HARDE-RHEL-246"
}
@test "HARDE-RHEL-247 : Journaux d'activité de service" {
    skip "Pas d'audit automatique pour HARDE-RHEL-247"
}



