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
