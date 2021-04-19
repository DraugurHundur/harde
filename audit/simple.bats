load error.bash
load output.bash
load lang.bash
load audit-helpers.sh


@test "HARDE-RHEL-161 : S'assurer que les permissions sur /etc/crontab soient correctes" {
    check_owner root /etc/crontab
    check_perm 0600 /etc/crontab
}