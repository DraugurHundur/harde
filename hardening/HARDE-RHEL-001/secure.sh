#! /bin/bash
echo "HARDE-RHEL-1 : Minimisation des services installés"
# If we're online update
dnf update
# packages that we depends on
dnf install --assumeyes net-tools tar policycoreutils-python-utils \
  setools-console chrony rsyslog bzip2 firewalld audit usbguard rng-tools \
  openscap-scanner libcap-ng-utils aide rsyslog rsyslog-gnutls \
  audispd-plugins tmux dnf-automatic sssd-ipa sudo policycoreutils \
  python3-subscription-manager-rhsm fapolicyd aide scap-security-guide sssd \
  realmd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools \
  krb5-workstation openldap-clients python3-policycoreutils
dnf remove --assumeyes abrt-addon-ccpp abrt-plugin-sosreport iprutils nfs-utils \
  abrt-addon-python tuned abrt-addon-kerneloops gssproxy abrt-plugin-logger \
  abrt-cli abrt-plugin-rhtsupport sendmail abrt setroubleshoot \
  setroubleshoot-server mcstrans xinetd xorg-x11*.* ypbind telnet
# Fin: HARDE-RHEL-1
