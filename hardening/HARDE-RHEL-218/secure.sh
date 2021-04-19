echo "HARDE-RHEL-218 : Tracer les suppressions de fichiers"
cat >/etc/audit/rules.d/45delete.rules <<EOF
-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=4294967295 -k delete
EOF
# Fin: HARDE-RHEL-218
