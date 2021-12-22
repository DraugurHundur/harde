## HARDE-RHEL-019 : Partitionnement type

Le principe de minimisation pousse à partitionner le stockage pour limiter l'impact en cas de remplissage abusif (attaque, journaux, processus fou ...) et pour limiter les droits sur des emplacements ouverts en écriture (par exemple en mettant une partition complète en lecture seule ou en limitant la possibilité d'un utilitaire *suid* à la seule partition `/usr` celle-ci n'étant accessible qu'aux administrateurs).

Le chapitre Installation décrit le minimum de partitions à créer sur le système.

Voici la liste des options recommandées à appliquer dans le fichier /etc/fstab pour les points de montage :

Point de Montage | Options | Description
--|--|--
/ | *pas d'option* |Partition racine, contient le reste de l’arborescence
/boot et /boot/efi |nodev,nosuid,noexec,noauto |Contient le noyau et le chargeur de démarrage. Pas d’accès nécessaire une fois le boot terminé (sauf mise à jour)
/dev/shm |nodev,nosuid,noexec |Contient les segments de mémoire partagés
/home |nodev,nosuid,noexec |Contient les HOME utilisateurs. Montage en lecture seule si non utilisé
/opt |nodev,nosuid (ro optionnel) |Packages additionnels au système. Montage en lecture seule si non utilisé
/proc |hidepid=2,gid=sudogrp |Contient des informations sur les processus et le système
/srv |nodev,nosuid (noexec,ro optionnels) |Contient des fichiers servis par un service type web, ftp, etc.
/tmp |nodev,nosuid,noexec |Fichiers temporaires. Ne doit contenir que des éléments non exécutables. Nettoyé après redémarrage ou préférablement de type tmpfs
/usr |nodev (ro optionnel) |Contient la majorité des utilitaires et fichiers système
/var |nodev,nosuid,noexec |Partition contenant des fichiers variables pendant la vie du système (mails, fichiers PID, bases de données d’un service)
/var/log |nodev,nosuid,noexec |Contient les logs du système
/var/log/audit |nodev,nosuid,noexec |Contient les logs d'audit du système
/var/tmp |nodev,nosuid,noexec |Fichiers temporaires conservés après extinction

Le script rajoute les lignes suivantes :

```text
proc /proc  proc rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=sudogrp 0 0
none /dev/shm tmpfs nosuid,nodev,noexec,defaults             0 0
```

À titre d’exemple, voici le fichier édité pour une machine virtuelle (sans les options « ro » de lecture seule) :

```text
#
# /etc/fstab
# Created by anaconda on Fri Sep 11 11:21:06 2020
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
/dev/mapper/rhel_lab-root   /                     xfs    defaults      0 0
UUID=3fe99bee-938f-4751-a956-b4335bc32e7c  /boot           xfs    nosuid,nodev,noexec,noauto,defaults          0 0
UUID=16FD-1FB3             /boot/efi          vfat   nosuid,nodev,noexec,noauto,umask=0077,shortname=winnt  0 2
/dev/mapper/rhel_lab-home    /home             xfs    nosuid,nodev,noexec,defaults           0 0
/dev/mapper/rhel_lab-srv    /srv                xfs   nosuid,nodev,defaults            0 0
/dev/mapper/rhel_lab-tmp    /tmp                    xfs    nosuid,nodev,noexec,defaults           0 0
/dev/mapper/rhel_lab-usr    /usr                   xfs    nodev,defaults             0 0
/dev/mapper/rhel_lab-var    /var                xfs    nosuid,nodev,noexec,defaults           0 0
/dev/mapper/rhel_lab-var_log    /var/log       xfs    nosuid,nodev,noexec,defaults           0 0
/dev/mapper/rhel_lab-var_log_audit   /var/log/audit   xfs    nosuid,nodev,noexec,defaults           0 0
/dev/mapper/rhel_lab-var_tmp      /var/tmp         xfs    nosuid,nodev,noexec,defaults           0 0
/dev/mapper/rhel_lab-swap       swap                  swap   defaults             0 0
proc                    /proc              proc   rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=sudogrp 0 0
none                      /dev/shm             tmpfs  nosuid,nodev,noexec,defaults    0 0
```