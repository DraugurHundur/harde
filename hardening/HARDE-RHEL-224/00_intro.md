## HARDE-RHEL-224 : S'assurer que le système s'arrête si le système d'audit est plein

Dans /etc/audit/auditd.conf, s'assurer que le paramètre admin_space_left_action soit positionné à halt. 
Cela suppose que l'espace disque est supervisé, une partition d'audit remplie entrainant un arrêt du système.

