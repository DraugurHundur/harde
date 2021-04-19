echo "HARDE-RHEL-222 : S'assurer que la taille de stockage est spécifiée"
if  ! grep -q -E '^max_log_file = 8' /etc/audit/auditd.conf ; then sed -e 's/\(max_log_file .*\)/#HARDE-RHEL-222: \1/' -i /etc/audit/auditd.conf; echo "max_log_file = 8" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-222
