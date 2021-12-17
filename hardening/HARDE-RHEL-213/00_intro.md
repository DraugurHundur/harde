## HARDE-RHEL-213 : S'assurer que la valeur d'audit_backlog_limit est suffisante

Éditer /etc/default/grub et modifier le paramètre GRUB_CMDLINE_LINUX pour inclure audit_backlog_limit=8192 puis lancer la commande suivante :

