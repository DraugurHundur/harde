echo "HARDE-RHEL-60 : S'assurer que RPC est désactivé"
systemctl --now disable rpcbind || true
# Fin: HARDE-RHEL-60
