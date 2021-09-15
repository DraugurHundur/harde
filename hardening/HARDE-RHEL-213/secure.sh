echo "HARDE-RHEL-213 : S'assurer que la valeur d'audit_backlog_limit est suffisante"
if ! grep -q -E 'audit_backlog_limit=' /etc/default/grub; then
  sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 audit_backlog_limit=8192"/' -i /etc/default/grub
  echo "Parameter audit_backlog_limit added."
fi
grub2-mkconfig –o /boot/grub2/grub.cfg >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg >/dev/null
# Fin: HARDE-RHEL-213
