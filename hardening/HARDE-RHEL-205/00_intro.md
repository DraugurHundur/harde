## HARDE-RHEL-205 : Désactivation du chargement des modules noyau

### Description
Le chargement des modules est interdit par un service lancé à la fin du processus de démarrage (via un booléen SELinux et la désactivation de certains modules). En particulier, le stockage USB, les CD-ROM et les systèmes de fichiers sont inaccessibles en appliquant cette règle.

Un commande `/etc/maintenance_mode.sh` permet de basculer dans un mode où le chargement est autorisé par exemple, lors d'une mise à jour. Une fois lancée, le système doit être redémarré.

