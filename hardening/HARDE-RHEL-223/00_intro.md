## HARDE-RHEL-223 : S'assurer que les logs d'audit ne soient pas purgés

### Description
dans /etc/audit/auditd.conf, s'assurer que le paramètre max_log_file_action soit positionné à keep_logs

Dans la pratique, il faut de manière régulière purger les journaux les plus anciens pour ne pas saturer la partition d'audit. Les paramètres d'auditd ne permettent pas de rotation basé sur les dates, un script lancé par cron est donc utilisé pour assurer une rotation basé sur l'âge. Ici, les journaux sont conservés un mois (variable NUM_LOGS du script positionnée à 30).
