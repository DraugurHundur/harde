
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-041 :

``` {.bash .numberLines}
echo "HARDE-RHEL-41 : Verrouiller par mot de passe la configuration de demarrage"
while ! grub2-setpassword -o /boot/grub2; do
  echo "Mot de passe non enregistré. Veuillez réessayer ..."
done
cp /boot/grub2/user.cfg /boot/efi/EFI/redhat/
# Fin: HARDE-RHEL-41
```

