## HARDE-RHEL-137 : S'assurer que la connexion *root* est seulement possible sur la console système

L'accès direct à une session *root* doit être restreint aux seules consoles physiquement connectées au serveur. Cela permet de s'assurer qu'un attaquant ne puisse ouvrir à distance de session *root* même en cas de compromission du mot de passe. HARDE-RHEL-110 s'assure que le connexion ne soit pas possible par SSH.

S'il n'y a qu'une console série (par exemple `/dev/ttyS1`) ou pour les conteneurs qui n'ont que des consoles virtuelles (par exemple `/dev/pts/0`), il faut éditer le fichier `/etc/securetty` pour n'inclure que ces consoles.
