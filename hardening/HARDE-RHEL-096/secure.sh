#! /bin/bash
echo "HARDE-RHEL-96 : Paramétrage des booléens SELinux"
setsebool -P allow_execheap=off
setsebool -P allow_execmod=off
setsebool -P deny_execmem=on
setsebool -P allow_execstack=off
# paramètrage appliqué dynamiquement à la fin du processus de boot,
# en fonction du mode maintenance : setsebool -P secure_mode_insmod=on
setsebool -P ssh_sysadm_login=off
echo
# Fin: HARDE-RHEL-96
