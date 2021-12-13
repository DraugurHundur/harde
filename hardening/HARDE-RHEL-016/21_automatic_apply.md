
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-016 :

``` {.bash .numberLines}
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
usbguard generate-policy >/etc/usbguard/rules.conf
# Fin: HARDE-RHEL-16
```

