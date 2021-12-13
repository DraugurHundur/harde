
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-211 :

``` {.bash .numberLines}
echo "HARDE-RHEL-211 : S'assurer que le service auditd est activé"
systemctl --now enable auditd
# Fin: HARDE-RHEL-211
```

