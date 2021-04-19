echo "HARDE-RHEL-134 : S'assurer que les comptes système soient sécurisés"
chage -d 0 root
chage -d 0 ${ADMINUSER}
# Fin: HARDE-RHEL-134
