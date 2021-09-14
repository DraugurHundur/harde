### HARDE-RHEL-019 : Partitionnement type

#### Description
Les partitions permettent de segmenter l'espace de stockage et d'appliquer des directives de haut-niveau comme `noexec` pour empêcher l'exécution de logiciels.

Les partitions /tmp et /var/tmp sont traitées de manière légérement différente car elles sont gérées via pam_namespace.

Certains logiciels peuvent demander des permissions spéciales : par exemple docker-compose demande l'option `exec` sur la partition `/tmp`. Différents moyens pour permettre ce comportement sans compromettre la sécurité sont possibles:
 - monter la partition temporairement 
