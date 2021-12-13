
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-234 :

``` {.bash .numberLines}
echo "HARDE-RHEL-234 : Configurer les permissions des fichiers journaux"
cat >/etc/rsyslog.d/10FileCreate.conf <<EOF
\$FileCreateMode 0640
EOF
# Fin: HARDE-RHEL-234
```

