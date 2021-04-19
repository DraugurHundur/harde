echo "HARDE-RHEL-224 : S'assurer que le système s'arrête si le système d'audit est plein"
if  ! grep -q -E '^admin_space_left_action = halt' /etc/audit/auditd.conf ; then sed -e 's/\(admin_space_left_action .*\)/#HARDE-RHEL-224: \1/' -i /etc/audit/auditd.conf; echo "admin_space_left_action = halt" >> /etc/audit/auditd.conf; fi
# Fin: HARDE-RHEL-224
