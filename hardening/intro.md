#	MISE EN ŒUVRE
##	Sécurisation
###	Installation
Certains des paramètres de sécurisation sont uniquement ou plus facilement sélectionnables lors de l’installation. Ce sont, en particulier, la répartition des partitions et la sélection initiale de logiciels à installer. Ce guide décrit la procédure d’installation à suivre pour un Red Hat Linux Entreprise 8.1, 8.2 ou 8.3. 
Si ce guide n’a pas été suivi dès l’installation du système, il sera compliqué voire très fastidieux de mettre en place l’ensemble des règles définies dans ce guide.
L’installation du système est décrite au chapitre 3, page 6.
La documentation Red Hat est disponible sur le site : https://access.redhat.com/documentation/fr-fr/red_hat_enterprise_linux/8/html-single/performing_a_standard_rhel_installation/index
Pour rappel, pendant l’installation et avant l’installation des correctifs de sécurité, l’ordinateur est potentiellement vulnérable et doit donc être déconnecté ou au pire connecté à un réseau maitrisé.

###	Application automatique
Quand cela est possible, les règles de sécurisation ont été traduites dans un script qui permet d’appliquer les paramètres demandés sans interaction de l’utilisateur.

###	Opérations manuelles
Un certain nombre d’opérations (trop complexes ou dépendantes du réseau d’installation) sont à réaliser manuellement, et sont décrites dans le chapitre 4.2.

##	Audit
L’audit permet de s’assurer que le système est correctement configuré. Il est à réaliser à intervalles réguliers pour s’assurer qu’il n’y a pas de déviations ou de dérive du système. En particulier, les mises à jour du système peuvent modifier des permissions sur le système de fichiers.
L’audit est décrit au chapitre 5, page 12.

#	INSTALLATION DU SYSTEME

##	Sur une machine virtuelle
Il est conseillé de s’assurer que le matériel virtualisé soit réduit au minimum : par exemple pas de carte son, pas de port série … pour limiter la surface d’attaque.
Le disque dur alloué doit être au minimum de 48 Go

##	Depuis une image ISO
 
Démarrer le système depuis l’image ISO, puis dès que l’installateur graphique est démarré, sélectionner France, Français(France) comme paramètres linguistiques. S’assurer que le clavier est positionné à fr(oss) après avoir cliqué sur Continuer.
 
Depuis l’écran Résumé de l’installation, positionner la Sélection Logiciel à « Installation minimale » :


Depuis l’écran Résumé de l’installation, positionner le paramètre KDUMP à désactivé :
 
Depuis l’écran Résumé de l’installation, cliquer sur « Nom du réseau &…» pour activer la carte réseau et modifier les différents paramètres réseau (dont le nom DNS). 
 
Depuis l’écran principal, régler l’heure & date pour pointer vers le fuseau horaire cible et si disponible, définir une ou plusieurs sources NTP fiables.
Depuis l’écran Résumé de l’installation, pour le partitionnement du disque dur, choisissez ‘Personnalisé’ (cliquer sur Fait) puis garder les options par défaut pour le disque (LVM) et cliquer sur + pour créer les partitions suivantes :

Point de montage | Taille Minimum
--|--
/	| 4 Gio
/boot	| 1 Gio
/boot/efi	| 512 Mio
/usr	| 12 Gio
/tmp	| 1 Gio
/home	| 2 Gio
/var	| 4 Gio
/var/log	| 4 Gio
/var/tmp	| 4 Gio
/var/log/audit	| 4 Gio
/srv ou /opt	| 6 Gio
swap	| 4 Gio (ou 20% de la mémoire vive) 

Ne pas sélectionner de politique de sécurité.
Le chapitre But du système est optionnel et pour information seulement.
Cliquer sur Commencer l’installation.
 
Définir un mot de passe administrateur (root) et créer un compte utilisateur. Veiller à choisir des mots de passe conformes à la politique de sécurité.
Redémarrer une fois l’installation terminée :
 
Passer ensuite à la sécurisation dans le chapitre ci-dessous.
#	SECURISATION
Une fois l’installation terminée selon le chapitre précédent, la sécurisation proprement dite se passe en deux étapes :
1.	Appliquer les correctifs et mises à jour de sécurité.
2.	Effectuer les opérations manuelles détaillés ci-dessous.
3.	Lancer le script fourni en attachement.

##	Correctifs
Red Hat Enterprise 8.1 nécessite d’avoir les correctifs/erratas suivants installés pour un fonctionnement correct du système (liste non exhaustive) :
https://access.redhat.com/errata/RHBA-2020:0334
https://access.redhat.com/errata/RHBA-2020:1773

Pour rappel, il est évidemment nécessaire d’installer au plus tôt les dernières mises à jour de sécurité.

##	Opérations Manuelles
Editer le fichier /etc/fstab pour rajouter les options sur les points de montage suivant le tableau suivant :

Point de Montage | Options | Description
--|--|--
/	|<sans option>	Partition racine, contient le reste de l’arborescence
/boot et /boot/efi	|nodev,nosuid,noexec,noauto	|Contient le noyau et le chargeur de démarrage. Pas d’accès nécessaire une fois le boot terminé (sauf mise à jour)
/dev/shm	|nodev,nosuid,noexec	|Contient les segments de mémoire partagés
/home	|nodev,nosuid,noexec	|Contient les HOME utilisateurs. Montage en lecture seule si non utilisé
/opt	|nosuid,nodev (ro optionnel)	|Packages additionnels au système. Montage en lecture seule si non utilisé
/proc	|hidepid=2,gid=sudogrp	|Contient des informations sur les processus et le système
/srv ou /opt	|nosuid,nodev (noexec,ro optionnels)	|Contient des fichiers servis par un service type web, ftp, etc.
/tmp	|nodev,nosuid,noexec	|Fichiers temporaires. Ne doit contenir que des éléments non exécutables. Nettoyé après redémarrage ou préférablement de type tmpfs
/usr	|nodev (ro optionnel)	|Contient la majorité des utilitaires et fichiers système
/var	|nodev,nosuid,noexec	|Partition contenant des fichiers variables pendant la vie du système (mails, fichiers PID, bases de données d’un service)
/var/log	|nodev,nosuid,noexec	|Contient les logs du système
/var/log	|nodev,nosuid,noexec	|Contient les logs d'audit du système
/var/tmp	|nodev,nosuid,noexec	|Fichiers temporaires conservés après extinction

Rajouter les lignes suivantes :
proc	/proc		proc	rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=sudoers	0 0
none	/dev/shm	tmpfs	nosuid,nodev,noexec,defaults					0 0

À titre d’exemple, voici le fichier édité pour une machine virtuelle (sans les options « ro » de lecture seule) :
```
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
/dev/mapper/rhel_lab-root			/                    	xfs   	defaults						0 0
UUID=3fe99bee-938f-4751-a956-b4335bc32e7c 	/boot                	xfs   	nosuid,nodev,noexec,noauto,defaults        		0 0
UUID=16FD-1FB3          			/boot/efi    		vfat  	nosuid,nodev,noexec,noauto,umask=0077,shortname=winnt 	0 2
/dev/mapper/rhel_lab-home 			/home       		xfs   	nosuid,nodev,noexec,defaults        			0 0
/dev/mapper/rhel_lab-srv 			/srv      		xfs  	nosuid,nodev,defaults        				0 0
/dev/mapper/rhel_lab-tmp 			/tmp           	xfs   	nosuid,nodev,noexec,defaults        			0 0
/dev/mapper/rhel_lab-usr 			/usr              	xfs   	nodev,defaults        					0 0
/dev/mapper/rhel_lab-var 			/var          		xfs   	nosuid,nodev,noexec,defaults        			0 0
/dev/mapper/rhel_lab-var_log 			/var/log     		xfs   	nosuid,nodev,noexec,defaults        			0 0
/dev/mapper/rhel_lab-var_log_audit 		/var/log/audit  	xfs   	nosuid,nodev,noexec,defaults        			0 0
/dev/mapper/rhel_lab-var_tmp	   		/var/tmp        	xfs   	nosuid,nodev,noexec,defaults        			0 0
/dev/mapper/rhel_lab-swap 	   		swap                 	swap  	defaults        					0 0
proc    			   		/proc    		proc  	rw,nosuid,nodev,noexec,relatime,hidepid=2,gid=sudogrp	0 0
none      			   		/dev/shm        	tmpfs 	nosuid,nodev,noexec,defaults				0 0
```
## 	Lancer le script de sécurisation
Copier le script fourni en attachement dans le répertoire /root, puis le lancer dans une session root (ou dans une session sudo). Il est obligatoire d’avoir inséré un DVD d’installation dans le lecteur (ou à défaut d’avoir monté l’image ISO sur le répertoire /mnt/disc). Une fois lancé, le script pose quelques questions pour affiner le paramétrage.
Une fois la sécurisation effectuée (et le système redémarré), il n’est plus possible de relancer le script : le montage des images ISO n’étant plus possible. Voir le chapitre 7.7 pour les procédures à appliquer pour utiliser des supports externes.

##	Documents à établir
La directive HARDE-RHEL-51 demande à ce qu’une liste blanche des démons (services résidents) soit établie.
La directive HARDE-RHEL-143 demande à ce qu’une liste blanche et une liste noire des utilisateurs soient établies.
#	AUDIT	
Le catalogue des règles de sécurisation donne le détail des étapes à réaliser pour auditer le système. Comme pour la sécurisation, lorsque cela a été possible, ces étapes ont été automatisées à l’aide d’un script audit.sh fourni en attachement. Ce script a été écrit en utilisant le framework bats-core (également fourni en attachement).

# CATALOGUE DES REGLES DE SECURISATION
Ce catalogue contient des règles définies à partir des recommandations ANSSI ([REF2]) et du benchmark CIS ([REF 3]).
Certaines de ces règles sont positionnées à « Ne pas implémenter » car elles ont été jugées non pertinentes ou non applicables dans le cadre de ce projet. Elles sont néanmoins présentes pour offrir une vision globale des recommandations.
La majorité de ces règles sont mis en place par un paramétrage du système mais certaines demandent la mise en place de procédures organisationnelles

