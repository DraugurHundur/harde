## HARDE-RHEL-017 : S'assurer de la configuration de /var

### Description
`/var` doit être installé dans une partition séparée d'au moins 4GB avec les options nodev,noexec et nosuid.

Beaucoup de logiciels nécessitent néanmoins des droits d'exécution dans des sous-répertoires (par exemple /var/lib/raas/unpack pour VMWare SaltStack Config). Dans ces cas-là, il est recommandé de créer une partition dédiée à cette application (ici avec lvm): 
```bash
lvcreate -L 4G rhel_redhat -n raas_unpack
mkdir /var/lib/raas
mkdir /var/lib/raas/unpack
chown -R raas:raas /var/lib/raas
cat >>/etc/fstab <<EOF
/dev/mapper/rhel_redhat-raas_unpack /var/lib/raas/unpack          xfs     nosuid,nodev,defaults        0 0
EOF
mount /var/lib/raas/unpack
```
