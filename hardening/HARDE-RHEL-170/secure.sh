echo "HARDE-RHEL-170 : S'assurer que l'umask utilisateur est ou plus restrictif"
# Shells non-interactifs
sed -i -e 's/umask 0../umask 027/' /etc/bashrc
# Shells interactifs
cat >/etc/profile.d/umask.sh <<EOF
umask 027
EOF
# Fin: HARDE-RHEL-170
