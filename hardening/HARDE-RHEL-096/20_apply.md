### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-096:
```bash
setsebool -P allow_execheap=off
setsebool -P allow_execstack=off
# paramètrage appliqué dynamiquement à la fin du processus de boot : setsebool -P secure_mode_insmod=on
# A passer à on si des administrateurs doivent se connecter à distance
echo -n "Autoriser les administrateurs à se connecter par SSH ? "; read -e -i "O" -r ADMINSSH
if [ -z "${ADMINSSH}" ]; then
    setsebool -P ssh_sysadm_login=off
else
    setsebool -P ssh_sysadm_login=on
fi
echo
# Fin: HARDE-RHEL-96
```
