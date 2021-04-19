echo "HARDE-RHEL-129 : S'assurer que l'expiration des mots de passe soit de 365 jours ou moins"
if  ! grep -q -E '^PASS_MAX_DAYS\s+365' /etc/login.defs ; then sed -e 's/\(PASS_MAX_DAYS.*\)/# \1/' -i /etc/login.defs; echo "PASS_MAX_DAYS 365" >> /etc/login.defs; fi
# Fin: HARDE-RHEL-129
