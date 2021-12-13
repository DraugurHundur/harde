#### Méthode d'audit
Il n'y a pas de méthode automatique pour déterminer que la configuration est aussi minimale que possible.

Le script d'audit fait une capture des processus exécutés. Cette doit être revue manuellement et comparée entre deux exécutions successives pour déterminer la légitimité des processus présents.

```bash
# lister les processus
ps aux
# lister les services réseaux
ss -tulpen
# lister les sockets UNIX
ss -xp
```
