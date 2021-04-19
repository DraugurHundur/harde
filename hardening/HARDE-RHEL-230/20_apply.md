### Méthode d'implémentation
Pour se faire utiliser le script fourni, dont voici le code source concernant HARDE-RHEL-230:
```bash
cat >/etc/audit/rules.d/85system-locale.rules <<EOF
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname -S setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/sysconfig/network -p wa -k system-locale
EOF
# Fin: HARDE-RHEL-230
```
