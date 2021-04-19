### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-222:
```bash
if  ! grep -q -E '^max_log_file = 8' /etc/audit/auditd.conf ; then sed -e 's/\(max_log_file .*\)/#HARDE-RHEL-222: \1/' -i /etc/audit/auditd.conf; echo "max_log_file = 8" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-222
```
