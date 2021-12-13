
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-206 :

``` {.bash .numberLines}
echo "HARDE-RHEL-206 : Configuration sysctl du module Yama"
cat >/etc/sysctl.d/25yama.conf <<EOF
kernel.yama.ptrace_scope = 1
EOF
# Fin: HARDE-RHEL-206
```

