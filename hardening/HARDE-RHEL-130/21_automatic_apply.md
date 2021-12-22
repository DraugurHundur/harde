
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-130 :

``` {.bash .numberLines}
echo "HARDE-RHEL-130 : S'assurer que le nombre minimum de jours entre 2 changements de mot de passe soit 7 ou plus"
if ! grep -q -E '^PASS_MIN_DAYS\s+365' /etc/login.defs; then
  sed -e 's/\(PASS_MIN_DAYS.*\)/# \1/' -i /etc/login.defs
  echo "PASS_MIN_DAYS 7" >>/etc/login.defs
fi
# Fin: HARDE-RHEL-130
```

