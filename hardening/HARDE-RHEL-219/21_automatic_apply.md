
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-219 :

``` {.bash .numberLines}
echo "HARDE-RHEL-219 : Tracer le chargement/déchargement de modules"
cat >/etc/audit/rules.d/50modules.rules <<EOF
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-a always,exit -F arch=b64 -S init_module -S delete_module -k modules
EOF
# Fin: HARDE-RHEL-219
```

