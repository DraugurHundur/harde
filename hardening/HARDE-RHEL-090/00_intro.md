## HARDE-RHEL-090 : S'assurer que l'accès SSH soit limité

Éditer le fichier /etc/ssh/sshd_config pour restreindre la connexion aux membres du groupe sudoers:
AllowGroups sudogrp
DenyUsers root

