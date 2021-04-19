echo "HARDE-RHEL-135 : S'assurer que la temporisation par défaut des shell utilisateurs soit de 900 secondes ou moins"
cat >/etc/profile.d/tmout.sh <<EOF
readonly TMOUT=900 ; export TMOUT
EOF
# Fin: HARDE-RHEL-135
