echo "HARDE-RHEL-227 : Collecter toutes les informations de session"
cat >/etc/audit/rules.d/70logins.rules <<EOF
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k logins
-w /var/log/btmp -p wa -k logins
EOF
# Fin: HARDE-RHEL-227
