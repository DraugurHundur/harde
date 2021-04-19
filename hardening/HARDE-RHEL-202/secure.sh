echo "HARDE-RHEL-202 : Désactiver la création de core dumps"
cat >/etc/sysctl.d/15suid_dumpable.conf <<EOF
# Pas de core dump des exécutables setuid
fs.suid_dumpable = 0
EOF
cat >/etc/security/limits.d/10core.conf <<EOF
* hard core 0
EOF
# Fin: HARDE-RHEL-202
