
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-212 :

``` {.bash .numberLines}
echo "HARDE-RHEL-212 : S'assurer que l'audit commence au plus tôt"
if ! grep -q -E 'auditd=' /etc/default/grub; then
  sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 auditd=1"/' -i /etc/default/grub
  echo "Parameter auditd added."
fi
grub2-mkconfig –o /boot/grub2/grub.cfg >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg >/dev/null
# Fin: HARDE-RHEL-212
```

