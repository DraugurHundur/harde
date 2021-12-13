## HARDE-RHEL-129 : S'assurer que l'expiration des mots de passe soit de 365 jours ou moins

### Description

S'assurer que la ligne suivante soit dans le fichier /etc/login.defs:
PASS_MAX_DAYS 365

