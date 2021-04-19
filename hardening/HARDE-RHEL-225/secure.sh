echo "HARDE-RHEL-225 : Auditer tout changement du fichier sudoers"
cat >/etc/audit/rules.d/60scope.rules<<EOF
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
EOF
# Fin: HARDE-RHEL-225
