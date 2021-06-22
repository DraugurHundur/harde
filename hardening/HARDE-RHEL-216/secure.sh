#! /usr/bin/env bash
echo "HARDE-RHEL-216 : Journalisation de l'activité par auditd"
# Remove any pre-existing rules
rm -f /etc/audit/rules.d/audit.rules || true
cat >/etc/audit/rules.d/00audit.rules<<EOF
## First rule - delete all
-D
## Increase the buffers to survive stress events.
## Make this bigger for busy systems
-b 8192
## This determine how long to wait in burst of events
--backlog_wait_time 60000
## Set failure mode to syslog
-f 1
EOF
cat >/etc/audit/rules.d/10etc.rules <<EOF
# Journaliser les modifications dans /etc/
-w /etc/ -p wa
EOF
cat >/etc/audit/rules.d/20mount.rules<<EOF
# Surveillance de montage/démontage
-a exit,always -S mount -S umount2 -k mounts
EOF
cat >/etc/audit/rules.d/30syscalls.rules <<EOF
# Appels de syscalls x86 suspects
-a exit,always -S ioperm -S modify_ldt
# Appels de syscalls qui doivent être rares et surveillés de près
-a exit,always -S get_kernel_syms -S ptrace
-a exit,always -S prctl
EOF
# Fin: HARDE-RHEL-216
