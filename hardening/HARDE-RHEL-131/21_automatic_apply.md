
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-131 :

``` {.bash .numberLines}
echo "HARDE-RHEL-131 : S'assurer que l'alerte pour expiration de mot de passe soit émise 7 jours ou plus avant expiration du mot de passe"
if ! grep -q -E '^PASS_WARN_AGE\s+14' /etc/login.defs; then
  sed -e 's/\(PASS_WARN_AGE.*\)/# \1/' -i /etc/login.defs
  echo "PASS_WARN_AGE 14" >>/etc/login.defs
fi
# Fin: HARDE-RHEL-131
```

