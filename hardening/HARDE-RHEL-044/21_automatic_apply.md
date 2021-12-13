
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-044 :

``` {.bash .numberLines}
echo "HARDE-RHEL-44 : Configurer la connexion Red Hat Subscription Manager"
sed -e s/enabled=1/enabled=0/ -i /etc/yum/pluginconf.d/subscription-manager.conf
# Fin: HARDE-RHEL-44
```

