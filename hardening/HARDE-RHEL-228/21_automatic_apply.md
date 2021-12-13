
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-228 :

``` {.bash .numberLines}
echo "HARDE-RHEL-228 : S'assurer que les évenement de changements horaires soient tracés"
cat >/etc/audit/rules.d/75time-change.rules <<EOF
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex -S settimeofday -S stime -k time-change
-a always,exit -F arch=b64 -S clock_settime -k time-change
-a always,exit -F arch=b32 -S clock_settime -k time-change
-w /etc/localtime -p wa -k time-change
EOF
# Fin: HARDE-RHEL-228
```

