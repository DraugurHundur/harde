#! /bin/bash
echo "HARDE-RHEL-148 : Sécurisation des services réseau d'authentification PAM"
cat >/etc/pam.d/su <<EOF
#%PAM-1.0
auth            required        pam_env.so
auth            sufficient      pam_rootok.so
# Uncomment the following line to implicitly trust users in the ""wheel"" group.
#auth           sufficient      pam_wheel.so trust use_uid
# Uncomment the following line to require a user to be in the ""wheel"" group.
#auth           required        pam_wheel.so use_uid
# The following line requires a user to be in the ""sudogrp"" group.
auth            required        pam_wheel.so group=sudogrp
auth            substack        system-auth
auth            include         postlogin
account         sufficient      pam_succeed_if.so uid = 0 use_uid quiet
account         include         system-auth
password        include         system-auth
session         include         system-auth
session         include         postlogin
session         optional        pam_xauth.so
EOF
# Fin: HARDE-RHEL-148
