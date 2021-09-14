#! /bin/bash
echo "HARDE-RHEL-37 : Désactiver IPV6"
cat >/etc/sysctl.d/70disable_ipv6.conf <<EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF
# Samba and others may require the stack to be available, even with no interfaces 
# so the follwoing will have to be disabled
if ! grep -q -E 'ipv6.disable=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 ipv6.disable=1"/' -i /etc/default/grub ; echo "Parameter ipv6.disable added."; fi
grub2-mkconfig –o /boot/grub2/grub.cfg  >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-37
