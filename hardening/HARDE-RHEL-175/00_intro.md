## HARDE-RHEL-175 : Auditer les exécutables SUID

Les exécutables setuid doivent être le moins nombreux possible. Lorsqu’il est attendu que seuls les administrateurs de la machine les exécutent, il faut leur retirer le bit set-uid et leur préférer des commandes comme su ou sudo, qui peuvent être surveillées.

