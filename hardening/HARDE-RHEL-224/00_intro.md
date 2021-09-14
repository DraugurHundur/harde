## HARDE-RHEL-224 : S'assurer que le système s'arrête si le système d'audit est plein

### Description
Dans /etc/audit/auditd.conf, s'assurer que le paramètre admin_space_left_action soit positionné à halt. 

Cela suppose que l'espace disque soit supervisé, une partition d'audit remplie entrainant un arrêt du système.

Dans la pratique, il faut de manière régulière purger les logs les plus anciens pour ne pas saturer la partition d'audit. Les paramètres d'auditd ne permettent pas de rotation basé sur les dates, il faut donc configurer logrotate (et que SELinux permette la rotation)