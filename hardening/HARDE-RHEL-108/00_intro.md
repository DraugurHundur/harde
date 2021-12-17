## HARDE-RHEL-108 : S'assurer que les commandes sudo utilisent un pseudo-TTY et autres directives

La commande suivante permet de bloquer les administrateurs qui, par défaut, ne peuvent donc pas lancer de commande en tant que root, seulement éditer des fichiers par sudoedit. En supprimant le noexec, ils pourront lancer une commande arbitraire. L'alternative est de spécifier une liste blanche en modifiant la liste dans /etc/sudoers.d/15group

