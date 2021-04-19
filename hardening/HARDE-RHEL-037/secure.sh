echo "HARDE-RHEL-37 : Désactiver IPV6"
if ! grep -q -E 'ipv6.disable=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 ipv6.disable=1"/' -i /etc/default/grub ; echo "Parameter ipv6.disable added."; fi
grub2-mkconfig –o /boot/grub2/grub.cfg  >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-37
