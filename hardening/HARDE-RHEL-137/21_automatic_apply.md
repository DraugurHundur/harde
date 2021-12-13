
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-137 :

``` {.bash .numberLines}
#! /bin/bash
echo "HARDE-RHEL-137 : S'assurer que la connexion est root est seulement possible sur la console système"
for i in 1 2 3 4 5 6; do echo "tty$i" >/etc/securetty; done
echo "ttyS1" >>/etc/securetty
# enable pam_securetty.so as well
AUTH_FILES=(
    [0]="/etc/pam.d/system-auth"
    [1]="/etc/pam.d/password-auth"
)
for pamFile in "${AUTH_FILES[@]}"; do
    [ ! -e "$pamFile.harde-backup" ] &&
        cp "$pamFile" "$pamFile.harde-backup"
done
cat >/etc/pam.d/system-auth <<EOF
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authselect is run.
auth        required      pam_env.so
auth        required      pam_securetty.so noconsole
auth        required      pam_faillock.so preauth silent deny=5 unlock_time=900
auth        sufficient    pam_unix.so try_first_pass
# auth        required      pam_faillock.so preauth silent deny=5 unlock_time=900
auth        required      pam_faillock.so authfail deny=5 unlock_time=900
auth        required      pam_deny.so

account     required      pam_unix.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
password    requisite     pam_pwhistory.so use_authtok remember=99
password    sufficient    pam_unix.so try_first_pass use_authtok shadow obscure sha512 rounds=65536
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
EOF
cp /etc/pam.d/system-auth /etc/pam.d/password-auth
# Fin: HARDE-RHEL-137
```

