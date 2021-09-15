echo "HARDE-RHEL-73 : Désactiver les protocoles DDCP, SCTP, RDS et TIPC"
for i in dccp sctp rds tipc; do
  cat >"/etc/modprobe.d/$i.conf" <<EOF
install $i /bin/true
EOF
  rmmod "$i" || true
done
# Fin: HARDE-RHEL-73
