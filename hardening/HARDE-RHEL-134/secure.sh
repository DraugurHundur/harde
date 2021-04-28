#! /usr/bin/env bash
echo "HARDE-RHEL-134 : S'assurer que les comptes système soient sécurisés"
# Expire passwords now to enforce the new password policy
chage -d 0 root
[ -z "${ADMINUSER}" ] || getent passwd "${ADMINUSER}" >/dev/null && chage -d 0 "${ADMINUSER}"
# Fin: HARDE-RHEL-134
