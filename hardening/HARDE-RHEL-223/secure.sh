#! /usr/bin/env bash
echo "HARDE-RHEL-223 : S'assurer que les logs d'audit ne soient pas purgés"
if  ! grep -q -E '^max_log_file_action = keep_logs' /etc/audit/auditd.conf
then 
    sed -e 's/\(max_log_file_action.*\)/#HARDE-RHEL-223: \1/' -i /etc/audit/auditd.conf
    echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf
fi
cat >/etc/cron.daily/auditd <<'EOF'
NUM_LOGS=30
# /var/log/audit/audit.log.XX
# Only keep the files where XX > NUM_LOGS
for log in /var/log/audit/audit.log.*
do
    extension="${log##*.}"
    # Ignore non-numeric extensions
    [ "$extension" -eq "$extension" ] 2>/dev/null || continue 
    [ "$extension" -gt $NUM_LOGS ] && /bin/rm -f "$log"
done
kill -USR1 $(/sbin/pidof auditd)
EOF
chmod 0500 /etc/cron.daily/auditd
# Fin: HARDE-RHEL-223

