
# UTILISATION DU SYSTÈME

## Ajouter un utilisateur

La commande useradd permet de créer un utilisateur :

`useradd robert`

La commande passwd permet de définir/changer son mot de passe :

`passwd robert`

À noter que l’utilisateur est créé par défaut avec le role SELinux user_u.

## Supprimer un utilisateur

La commande userdel permet de supprimer un utilisateur du système (l’option `-r` permet de supprimer son répertoire d’accueil).

Par exemple :

`userdel -r -Z untel`

## Ajouter un administrateur

Il faut créer un utilisateur selon le paragraphe précédent puis lui donner des droits via la commande suivante :

`usermod -G sudogrp -Z staff_u durand`

&#9755; Si l'ordinateur est connecté à un annuaire LDAP/AD, les administrateurs doivent être obligatoirement ajoutés à ce groupe pour pouvoir exécuter `sudo`.

## Supprimer un administrateur

Un administrateur peut être supprimé comme un utilisateur (via la commande `userdel`). S’il s’agit de supprimer son accès administrateur seulement, il faut lancer les commandes suivantes :

`semanage login --delete durand`

`gpasswd -d durand sudogrp`

## Ajouter un service

Il est possible de rajouter des services en portant une attention particulière à SELinux et firewalld.
SELinux peut empêcher un processus d’envoyer un email ou de se comporter en serveur HTTP. Par exemple, après avoir installé un serveur Apache, la commande suivante est nécessaire :

`setsebool -P httpd_can_network_connect 1`

D’autre part, il faut également ouvrir le port grâce à firewalld, par exemple, pour un serveur Apache :

`firewall-cmd --permanent --zone=public --add-service=http`

Évidemment, les options à activer dépendent du service, et une description complète déborde du cadre de ce guide.

## Se connecter en root

Il n’est possible de se connecter en root que sur une console « physique » c’est-à-dire les consoles (tty de 1 à 6) disponibles sur l’écran/clavier connectés directement à l’ordinateur. Pour les autres connexions, il faut passer par `sudo` (via `sudo -i`).

## Monter une partition

À cause de l’utilisation de pam_namespace, il est recommandé de modifier /etc/fstab (puis redémarrer) pour tous les points de montage destinés à être « permanents » ou visibles de tous les utilisateurs. Utiliser mount dans une session sudo ne rendra ce point de montage visible que dans la session courante (et sera donc invisible des autres utilisateurs).

D’autre part, la sécurisation par défaut empêche le chargement de modules noyaux, ce qui bloque donc l’utilisation de clés USB ou de CD/DVD (même sous la forme de fichiers ISO). Il faudra donc dans ces cas-là autoriser temporairement le chargement de modules noyaux :

### Images ISO (physiques ou virtuelles)

Suivant le format, les images ISO requièrent le module iso9660 ou udf. Ceux-ci n'étant pas chargés par défaut, il faut donc passer en mode de maintenance pour autoriser le chargement des modules.

Pour se faire, lancer la commande suivante :

`sudo /etc/maintenance_mode.sh`

Le script vous demande de redémarrer. Une fois le système à nouveau accessible, il devient possible d’utiliser de monter des images ISO.

### Clés USB

Là encore, il n’est pas possible d’utiliser de clés USB en mode normal et il faut donc passer en mode de maintenance.

Pour se faire, lancer la commande suivante :

`sudo /etc/maintenance_mode.sh`

Le script vous demande de redémarrer. Une fois le système à nouveau accessible, il devient possible d’utiliser des clés USB.

### Accéder à la partition /boot

Avant d’appliquer une mise à jour, il faut monter /boot et /boot/efi (souvent nécessaire lors des mises à jour) : il faut donc autoriser le chargement des modules:

`sudo /etc/maintenance_mode.sh`

Puis redémarrer. Ensuite monter le système de fichier :

`mount /boot && mount /boot/efi`

Une fois la mise à jour faite, redémarrer pour revenir en situation normale.

## Diagnostic SELinux

La commande ausearch permet de repérer les évènements liés à un blocage par SELinux.

Cette commande est très puissante et décrire l’ensemble des options possibles dépasse du cadre de ce guide. Pour plus d’information, nous renvoyons vers ce site : <https://wiki.centos.org/HowTos/SELinux>.

À titre d’exemple, la commande suivante est lancée et nous reporte un évènement « bloqué » :

`ausearch -m AVC,USER_AVC,SELINUX_ERR,USER_SELINUX_ERR -i`

Résultat :

```text
type=PROCTITLE msg=audit(12/09/2020 07:18:11.625:4768) : proctitle=ausearch -m AVC,USER_AVC,SELINUX_ERR,USER_SELINUX_ERR -i
type=PATH msg=audit(12/09/2020 07:18:11.625:4768) : item=0 name=/var/log/audit/audit.log nametype=UNKNOWN cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
type=CWD msg=audit(12/09/2020 07:18:11.625:4768) : cwd=/root
type=SYSCALL msg=audit(12/09/2020 07:18:11.625:4768) : arch=x86_64 syscall=openat success=no exit=EACCES(Permission non accordée) a0=0xffffff9c a1=0x55fd00b078f0 a2=O_RDONLY a3=0x0 items=1 ppid=6470 pid=6489 auid=blanchet uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts1 ses=22 comm=ausearch exe=/usr/sbin/ausearch subj=staff_u:staff_r:staff_t:s0-s0:c0.c1023 key=access
type=AVC msg=audit(12/09/2020 07:18:11.625:4768) : avc:  denied  { search } for  pid=6489 comm=ausearch name=/ dev="dm-4" ino=128 scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tcontext=system_u:object_r:auditd_log_t:s0 tclass=dir permissive=0
```

Il s’agit d’un utilisateur n’ayant pas pu exécuter la commande ausearch. La commande `audit2why` permet de comprendre la raison du blocage :

```text
grep '625:4768' /var/log/audit/audit.log | audit2why
type=AVC msg=audit(1599887891.625:4768): avc:  denied  { search } for  pid=6489 comm="ausearch" name="/" dev="dm-4" ino=128 scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tcontext=system_u:object_r:auditd_log_t:s0 tclass=dir permissive=0

        Was caused by:
                Missing type enforcement (TE) allow rule.

                You can use audit2allow to generate a loadable module to allow this access.
```

Une solution peut être de rajouter une permission à la politique SELinux via une nouvelle règle. La commande audit2allow permet de la générer :

```text
grep '625:4768' /var/log/audit/audit.log | audit2allow _M ausearch


#============= staff_t ==============
allow staff_t auditd_log_t:dir search;
```

Il faut alors lancer les commandes suivantes pour les charger :

`semodule -i ausearch.pp`

`checkmodule -m -M sudolog.te -o ausearch.mod`

Il peut être plus simple de passer en mode *permissive* pour établir l’ensemble des règles nécessaires au bon fonctionnement d’un service ou tester si ce sont les règles SELinux qui empêchent le bon fonctionnement d'un service. Ceci doit être réalisé dans un environnement de développement sécurisé. En mode *permissive*, seuls les logs sont générés et peuvent donc être manipulés par `ausearch`, `audit2why` et `audit2allow`.

## Agrandir une partition

Il suffit d’utiliser les outils classiques de LVM pour rajouter des disques ou étendre des partitions.

## Modifier le mot de passe de démarrage

Le mot de passe de démarrage qui protège les paramètres de «boot» est stocké dans le répertoire /boot. Pour pouvoir le modifier, il faut donc d’abord suivre la procédure de passage en mode «maintenance».
Une fois la partition accessible, lancer :

`grub2-setpassword -o /boot/grub2`

Et ensuite :

`cp /boot/grub2/user.cfg /boot/efi/EFI/redhat/`

## Modifier le serveur SYSLOG distant

Il faut modifier le fichier /etc/rsyslog.d/loghost.conf

## Modifier la source de référence de temps

Il faut modifier le fichier /etc/chrony.conf et remplacer la directive par défaut débutant par `pool x.rhel.pool.ntp.org …` par `server *adresse IP ou nom*`, puis relancer chrony.

## Joindre un domaine Windows

Lancer la commande suivante pour joindre un domaine, remplacer domain.com par le domaine cible, user1 par le nom d’administrateur et SERVERS pour l’OU destination :

```bash
sudo realm join domain.com -U 'user1' --computer-ou=OU=SERVERS --os-name="$(uname -o)" --os-version="$(uname -rsv)" --install='/' --verbose
```

Pour restreindre la connexion à un certain groupe/OU seulement (ici SUDOERS), lancer :

```bash
sudo realm deny -R domain.com -a
sudo realm permit -R domain.com -g SUDOERS
```

Si en plus les utilisateurs de ce groupe doivent avoir accès à sudo, il faut les rajouter un à un au groupe sudogrp via :

`usermod -G sudogrp -Z staff_u durand`
