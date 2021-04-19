### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-043:
```bash
if ! grep -q -E 'iommu=' /etc/default/grub ; then sed -e 's/\(GRUB_CMDLINE_LINUX="[^"]*\)"/\1 iommu=force"/' -i /etc/default/grub ; echo "Parameter iommu added."; fi
grub2-mkconfig -o /boot/grub2/grub.cfg  >/dev/null
grub2-mkconfig –o /boot/efi/EFI/grub.cfg  >/dev/null
# Fin: HARDE-RHEL-43
```
