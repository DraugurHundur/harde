## HARDE-RHEL-018 : S'assurer de la configuration de /var/tmp

### Description
`/var/tmp` doit être installé dans une partition séparée d'au moins 1GB avec les options nodev,nosuid,noexec

### Références

----------------------  ---------------------
Niveau de durcissement            4

[CIS]                   RHEL 8 1.1.7
                        RHEL 8 1.1.8
                        RHEL 8 1.1.9
                        RHEL 8 1.1.10

Contrôles CIS           05.1 Establish Secure Configurations
                        05.1 Establish Secure Configurations
                        05.1 Establish Secure Configurations
                        02.6 Address unapproved software

[ANSSI]                   -
----------------------  ------------------------