echo "HARDE-RHEL-87 : Activation de SELinux avec la politique targeted"
selinuxenabled || setenforce 1 
fixfiles onboot
# Fin: HARDE-RHEL-87
