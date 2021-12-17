## HARDE-RHEL-143 : Désactivation des comptes utilisateurs inutilisés

Maintenir une liste blanche et noire d'utilisateurs.


Pour vérrouiller un compte, lancer la commande suivante :
usermod -L <compte>
et pour désactiver son shell de commande :
usermod -s /bin/false <compte>


