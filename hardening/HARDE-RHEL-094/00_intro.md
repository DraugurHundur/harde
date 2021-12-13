## HARDE-RHEL-094 : Répertoires temporaires dédiés aux comptes

### Description

pam_namespace est utilisé (installé par défaut sous Red Hat 8) mais une attention particulière doit être porté au montage temporaire (dans certains cas d'utilisation de su/sudo, les points de montage ne seront pas visibles des autres utilisateurs).
Ceci a également des effets sur les logiciels qui partagent entre sessions ou entre utilisateurs des fichiers ou des sockets dans /tmp. Dans ce cas-là il faut s'assurer que l'application soit configurée pour utiliser un répertoire spécifique. 

