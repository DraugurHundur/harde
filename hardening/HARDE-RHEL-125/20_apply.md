### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-125:
```bash
if  ! grep -q -E '^minlen' /etc/security/pwquality.conf ; then echo "minlen = 9">> /etc/security/pwquality.conf; fi
if  ! grep -q -E '^minclass' /etc/security/pwquality.conf ; then echo "minclass = 4">> /etc/security/pwquality.conf; fi
if  ! grep -q -E '^gecoscheck' /etc/security/pwquality.conf ; then echo "gecoscheck = 1">> /etc/security/pwquality.conf; fi
if  ! grep -q -E '^usercheck' /etc/security/pwquality.conf ; then echo "usercheck = 1">> /etc/security/pwquality.conf; fi
# Fin: HARDE-RHEL-125
```
