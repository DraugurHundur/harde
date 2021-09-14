### HARDE-RHEL-241 : S'assurer de la permission des fichiers journaux
Il s'agit de s'assurer que les droits d'accès aux journaux (qui peuvent contenir des informations sensibles) soient limités au maximum.

Cette règle peut causer des problèmes pour des services ne s'exécutant pas en root. Si cela est possible, il convient de modifier la configuration pour :
 - envoyer les logs de manière sécurisé à un serveur centralisé.
 - ou, sélectionner un répertoire différent en dehors de l'arborescence `/var/log`.   

#### Description

