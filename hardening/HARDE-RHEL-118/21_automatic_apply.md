
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-118 :

``` {.bash .numberLines}
#! /bin/bash
echo "HARDE-RHEL-118 : S'assurer que le paramètre SSH MaxSessions est positionné à 4 ou moins"
if ! grep -q -E '^MaxSessions\s+4' /etc/ssh/sshd_config; then
    sed -e 's/\(MaxSessions.*\)/#HARDE-RHEL-118 \1/' -i /etc/ssh/sshd_config
    echo "MaxSessions 4" >>/etc/ssh/sshd_config
fi
# Fin: HARDE-RHEL-118
```

