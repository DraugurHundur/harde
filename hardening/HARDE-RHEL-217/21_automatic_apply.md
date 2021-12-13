
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-217 :

``` {.bash .numberLines}
echo "HARDE-RHEL-217 : Tracer l'utilisation des commandes privilégiés"
find / /usr /srv -xdev \( -perm -4000 -o -perm -2000 \) -type f | awk '{print "-a always,exit -F path=" $1 " -F perm=x -F auid>='"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' -F auid!=4294967295 -k privileged" }' >/etc/audit/rules.d/25privileged.rules
# Fin: HARDE-RHEL-217
```

