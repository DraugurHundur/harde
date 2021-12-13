
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-125 :

``` {.bash .numberLines}
echo "HARDE-RHEL-125 : S'assurer que les exigences de création de mot de passe soient correctes"
if ! grep -q -E '^minlen' /etc/security/pwquality.conf; then echo "minlen = 9" >>/etc/security/pwquality.conf; fi
if ! grep -q -E '^minclass' /etc/security/pwquality.conf; then echo "minclass = 4" >>/etc/security/pwquality.conf; fi
if ! grep -q -E '^gecoscheck' /etc/security/pwquality.conf; then echo "gecoscheck = 1" >>/etc/security/pwquality.conf; fi
if ! grep -q -E '^usercheck' /etc/security/pwquality.conf; then echo "usercheck = 1" >>/etc/security/pwquality.conf; fi
# Fin: HARDE-RHEL-125
```

