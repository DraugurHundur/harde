---
title: HARDE - SÉCURISATION D'UN SYSTÈME RED HAT 8.x
author: Pierre Blanchet
lang: fr
---

Dernière mise à jour : {{date}}

\newpage

# Principes de base

Ce guide vise à rendre un système Red Hat plus résilient face aux attaques informatiques, ce qu'on appelle un système durci. Il se base principalement sur les recommandations [CIS] et [ANSSI].

Il introduit deux modes de fonctionnement du système : nominal et maintenance. En mode nominal, les points suivants sont désactivés :

- le chargement de modules noyaux.
- l'accès à la partition de démarrage /boot
- les supports de stockage externe.

 Pour les réactiver, il faut passer en mode « maintenance ». Pour passer d'un mode à l'autre, il est nécessaire de redémarrer le système.

Ce guide décrit la procédure à suivre pour un système Red Hat Linux Entreprise 8 (Testé avec les versions 8.1 à 8.5).

Si ce guide n’a pas été suivi dès l’installation du système, il sera compliqué voire très fastidieux de mettre en place l’ensemble des règles définies dans ce guide.

## Installation

Certains des paramètres de sécurisation sont uniquement ou plus facilement sélectionnables lors de l’installation. Ce sont, en particulier, la répartition des partitions et la sélection initiale de logiciels à installer.

L’installation du système est décrite au [chapitre ci-dessous](#installation-du-système).

La documentation constructeur est disponible sur [le site Red Hat](https://access.redhat.com/documentation/fr-fr/red_hat_enterprise_linux/8/html-single/performing_a_standard_rhel_installation/index).

Pour rappel, pendant l’installation et avant l’installation des correctifs de sécurité, l’ordinateur est potentiellement vulnérable et doit donc être déconnecté ou au pire connecté à un réseau maitrisé.

## Application automatique

Quand cela est possible, les règles de sécurisation ont été traduites dans un script qui permet d’appliquer les paramètres demandés sans interaction de l’utilisateur.

## Finalisation de la sécurisation

Un certain nombre d’opérations (trop complexes ou dépendantes du réseau d’installation) sont à réaliser manuellement, et sont décrites dans le chapitre [dédié](#opérations-manuelles).

## Audit

L’audit permet de s’assurer que le système est correctement configuré. Il est à réaliser à intervalles réguliers pour s’assurer qu’il n’y a pas de déviations ou de dérives du système. Par exemple, des mises à jour du système peuvent modifier des permissions sur le système de fichiers.

L’audit est décrit au [chapitre dédié](#audit-1).

# Installation du système

## Sur une machine virtuelle

Il est conseillé de s’assurer que le matériel virtualisé soit réduit au minimum : par exemple pas de carte son, pas de port série … pour limiter la surface d’attaque.
Le disque dur alloué doit être au minimum de 48 Go

## Depuis une image ISO

Démarrer le système depuis l’image ISO:
![Copie d'écran : Démarrage du DVD](images/dvd.png)

Puis dès que l’installateur graphique est démarré, sélectionner France, Français(France) comme paramètres linguistiques. S’assurer que le clavier est positionné à fr(oss) après avoir cliqué sur Continuer.

![Copie d'écran : Langue d'installation](images/language-selection.png)

Depuis l’écran principal, régler l’heure & date pour pointer vers le fuseau horaire cible et si disponibles, définir plusieurs sources NTP fiables.
![Copie d'écran : Configuration date et heure](images/date-time.png)

Depuis l’écran Résumé de l’installation, positionner la Sélection Logiciel à « Installation minimale » :

![Copie d'écran : Sélection Logiciel](images/software-selection.png)

Depuis l’écran Résumé de l’installation, positionner le paramètre KDUMP à désactivé :

![Copie d'écran : KDUMP est désactivé](images/kdump.png)

Depuis l’écran Résumé de l’installation, cliquer sur « Nom du réseau &…» pour activer la carte réseau et modifier les différents paramètres réseau (dont le nom DNS).

![Copie d'écran : Configuration du réseau](images/network-config.png)

Depuis l’écran Résumé de l’installation, dans le chapitre « Installation Destination » pour le partitionnement du disque dur, choisissez « Personnalisé » (cliquer sur Fait) :

![Copie d'écran : Configuration du stockage](images/storage.png)

Puis garder les options par défaut pour le disque (LVM). Cliquer sur + pour créer les partitions suivantes :

Point de montage | Taille Minimum
--|--
/ | 4 Gio
/boot | 1 Gio
/boot/efi | 512 Mio
/usr | 12 Gio
/tmp | 1 Gio
/home | 2 Gio
/var | 4 Gio
/var/log | 4 Gio
/var/tmp | 4 Gio
/var/log/audit | 4 Gio
/srv ou /opt | 6 Gio
swap | 4 Gio (ou 20% de la mémoire vive)

![Copie d'écran : Partitionnement](images/part1.png)

Valider les modifications à effectuer sur le disque :

![Copie d'écran : Partitionnement](images/part2.png)

Ne pas sélectionner de politique de sécurité.

Le chapitre But du système est optionnel et pour information seulement.

Définir un mot de passe administrateur (root) et créer un compte utilisateur. Veiller à choisir des mots de passe conformes à la politique de sécurité.

Quand tous les paramètres sont réglés, cliquer sur 'Commencer l'installation':
![Copie d'écran: Fin du paramétrage d'installation](images/installation-start.png)

Redémarrer une fois l’installation terminée :

![Copie d'écran : Fin d'installation](images/installation-end.png)

Passer ensuite à la sécurisation dans le chapitre ci-dessous : [Sécurisation](#sécurisation-1).

## Sécurisation

Une fois l’installation terminée selon le chapitre précédent, la sécurisation proprement dite se passe en quatre étapes :

1. Lancer le script fourni en attachement puis redémarrer.
1. Effectuer les opérations manuelles détaillés ci-dessous.
1. Appliquer les correctifs et mises à jour de sécurité.
1. Mettre en place les mesures organisationnelles de suivi (procédures de MCS, liste des utilisateurs, liste des services ...)

### Lancer le script de sécurisation

Copier le script fourni en attachement dans le répertoire /root, puis le lancer dans une session root (ou dans une session sudo).

Il est obligatoire d’avoir inséré un DVD d’installation dans le lecteur (ou à défaut d’avoir monté l’image ISO sur le répertoire /mnt/disc).

Une fois lancé, le script pose quelques questions pour affiner le paramétrage.

Une fois la sécurisation effectuée (et le système redémarré), il n’est plus possible de relancer le script : le montage des images ISO n’étant plus possible.

Voir le chapitre [Utiliser le système](#clés-usb) pour les procédures à appliquer pour utiliser des supports externes.

### Opérations Manuelles

#### Configuration de chrony

Le paquet `chrony` est installé pour assurer la synchronisation du temps. Il est primordial de s'assurer que le démon puisse contacter à minima un (au mieux 3) serveur de temps fiable. Voir [HARDE-RHEL-099](#harde-rhel-099-sassurer-que-chrony-est-configuré).

#### Configuration du puits de logs

Les journaux du système doivent être renvoyés sur un serveur central pour :

- empêcher leur modifications.
- les archiver selon la règlementation en vigueur.

Le script positionne automatiquement cette valeur mais pour la confirmer, voir [HARDE-RHEL-236](#harde-rhel-236-renvoyer-les-journaux-vers-un-hôte-distant).

### Correctifs

Pour rappel, il est évidemment nécessaire d’installer au plus tôt les dernières mises à jour de sécurité.

En plus des mises à jour de sécurité, des correctifs fonctionnels peuvent être nécessaires pour résoudre des défauts logiciels ou améliorer le fonctionnement du système.

Il est donc fortement recommandé qu'un processus de veille soit mise en place pour identifier au plus tôt les correctifs indispensables au maintien en condition de sécurité (MCS) ou nécessaires au bon fonctionnement du système (MCO).

### Documents à établir

La directive [HARDE-RHEL-51](#harde-rhel-051-services-et-démons-résidents-en-mémoire) demande à ce qu’une liste blanche des démons (services résidents) soit établie.

La directive [HARDE-RHEL-143](#harde-rhel-143-désactivation-des-comptes-utilisateurs-inutilisés) demande à ce qu’une liste blanche et une liste noire des utilisateurs soient établies.

## Vérifier la bonne application des règles

Le catalogue des règles de sécurisation donne le détail des étapes à réaliser pour auditer le système. Comme pour la sécurisation, lorsque cela a été possible, ces étapes ont été automatisées à l’aide d’un script harde.sh fourni en attachement. Ce script a été écrit en utilisant le framework bats-core (également fourni en attachement).

# CATALOGUE DES REGLES DE SECURISATION

Ce catalogue contient des règles définies à partir des recommandations [ANSSI] et du benchmark [CIS].
Certaines de ces règles sont positionnées à « Ne pas implémenter » car elles ont été jugées non pertinentes ou non applicables dans le cadre de ce projet. Elles sont néanmoins présentes pour offrir une vision globale des recommandations.
La majorité de ces règles sont mis en place par un paramétrage du système mais certaines demandent la mise en place de procédures organisationnelles.

[ANSSI]: https://www.ssi.gouv.fr/entreprise/guide/recommandations-de-securite-relatives-a-un-systeme-gnulinux/ (Recommandations de configuration d’un système GNU/Linux - v1.2)

[CIS]: https://www.cisecurity.org/benchmark/red_hat_linux/ (Securing Red Hat Linux 8)

\newpage
