
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-215 :

``` {.bash .numberLines}
echo "HARDE-RHEL-215 : Tracer les modifications d'utilisateurs"
cat >/etc/audit/rules.d/40identity.rules <<EOF
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
EOF
# Fin: HARDE-RHEL-215
```

