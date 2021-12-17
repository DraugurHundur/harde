## HARDE-RHEL-097 : Confinement des utilisateurs interactifs non privilégiés

Pour confiner un utilisateur à un rôle non privilégié avec SELinux, lancer la commande suivante :
usermod -Z user_u utilisateur
Les autres utilisateurs sont donc en mode unconfined_t

