## HARDE-RHEL-096 : Paramétrage des booléens SELinux

La politique SELinux inclut aussi des booléens permettant de définir des comportements particuliers du système. Aussi les booléens suivants sont positionnés à *off* :

* `allow_execheap` (interdit aux processus de rendre exécutable leur tas &mdash; *heap*);
* `allow_execstack` (interdit aux processus le droit de rendre leur pile &mdash; *stack* &mdash; exécutable);
* `allow_execmod` (interdit aux processus d'utiliser des bibliothèques qui demande la relocalisation de code ans être étiquetées *textrel_shlib_t*);
* `ssh_sysadm_login` (interdit les logins SSH de se connecter directement en rôle sysadmin).

Le booléen suivant est positionné à *on* :

* `deny_execmem` (interdit aux processus d’avoir une zone mémoire avec des droits en écriture &mdash;w&mdash; et en exécution &mdash;x&mdash;), aussi appelé W^X;

Le paramètre suivant est positionné au démarrage suivant le mode de fonctionnement (maintenance ou normal):

* `secure_mode_insmod` (interdit le chargement dynamique des modules par n’importe quel processus);

&#9755; Certains logiciels risquent de **mal fonctionner** à cause de réglages ci-dessus. La majeure partie du temps, le problème est du à une procédure de *build* incorrecte et doit donc être corrigé par l'éditeur.

À titre d'exemple, l'agent Trend Micro Deep Security 20.0 peut ne pas fonctionner. Les messages d'audit (*AVC* &mdash; remontent un `avc:  denied  { execstack }`) signalent que la bibliothèque `libcrypto.so.1.0.0` ne peut être chargée (*error while loading shared libraries: libcrypto.so.1.0.0: cannot enable executable stack as shared object requires: Permission denied*). En utilisant l'utilitaire `execstack` pour supprimer le drapeau demandant la pile exécutable, l'agent fonctionne correctement :

`execstack -c /opt/ds_agent/ds_agent/lib/libcrypto.so.1.0.0`

Un bonne pratique est alors de reporter à l'éditeur du logiciel en question cette incompatibilité en précisant que ces réglages pourraient être les règles par défaut des futures Red Hat.
