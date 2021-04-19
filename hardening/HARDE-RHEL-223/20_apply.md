### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-223:
```bash
if  ! grep -q -E '^max_log_file_action = keep_logs' /etc/audit/auditd.conf ; then sed -e 's/\(max_log_file_action.*\)/#HARDE-RHEL-223: \1/' -i /etc/audit/auditd.conf; echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-223
```
