## HARDE-RHEL-126 : S'assurer que le verrouillage après des tentatives de connexion soit configuré

### Description

Rajouter les lignes suivantes dans /etc/pam.d/password-auth et dans /etc/pam.d/system-auth:
auth        required      pam_faillock.so preauth silent deny=5 unlock_time=1800
auth        required      pam_faillock.so authfail deny=5 unlock_time=1800

