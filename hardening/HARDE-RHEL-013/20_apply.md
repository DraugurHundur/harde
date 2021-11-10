### Méthode d'implémentation
Ces options ont été activées lors des opérations manuelles après l'installation.

Rajouter la ligne suivante à /etc/fstab, *si* elle est manquante :

```
none	/dev/shm	tmpfs	nosuid,nodev,noexec,defaults					0 0
```
