## HARDE-RHEL-170 : S'assurer que l'umask utilisateur est ou plus restrictif

### Description

Le umask système doit être positionné à 0027 (par défaut, tout fichier créé n’est lisible que par l’utilisateur et son groupe, et modifiable uniquement par son propriétaire).
Le umask pour les utilisateurs doit être positionné à 0077 (tout fichier créé par un utilisateur n’est lisible et modifiable que par lui)

