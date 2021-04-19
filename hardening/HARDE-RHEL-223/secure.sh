echo "HARDE-RHEL-223 : S'assurer que les logs d'audit ne soient pas purgés"
if  ! grep -q -E '^max_log_file_action = keep_logs' /etc/audit/auditd.conf ; then sed -e 's/\(max_log_file_action.*\)/#HARDE-RHEL-223: \1/' -i /etc/audit/auditd.conf; echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-223
