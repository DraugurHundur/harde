echo "HARDE-RHEL-108 : S'assurer que les commandes sudo utilisent un pseudo-TTY et autres directives"
cat >/etc/sudoers.d/10secure <<EOF
Defaults noexec,requiretty,use_pty,umask=0027
Defaults ignore_dot,env_reset,passwd_timeout=1
Defaults timestamp_timeout=5
EOF
# Fin: HARDE-RHEL-108
