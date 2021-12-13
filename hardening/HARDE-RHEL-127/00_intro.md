## HARDE-RHEL-127 : S'assurer que la réutilisation d'anciens mots de passe soit limitée

### Description

Rajouter les lignes suivantes dans /etc/pam.d/password-auth et dans /etc/pam.d/system-auth:
password requisite pam_pwquality.so try_first_pass local_users_only enforce-for-root retry=3 remember=6
password sufficient pam_unix.so sha512 shadow try_first_pass use_authtok remember=6

