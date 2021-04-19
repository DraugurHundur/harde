### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-016:
```bash
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
```
