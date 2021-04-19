echo "HARDE-RHEL-235 : Définir les fichiers journaux"
cat >/etc/rsyslog.d/files.conf <<EOF
# Everybody gets emergency messages
*.emerg			:omusrmsg:*
# The authpriv file has restricted access.
auth,authpriv.*		/var/log/secure
# Log cron stuff
cron.*			/var/log/cron
mail.* 			-/var/log/mail
mail.info 		-/var/log/mail.info
mail.warning 		-/var/log/mail.warn
mail.err 		/var/log/mail.err
news.crit 		-/var/log/news/news.crit
news.err 		-/var/log/news/news.err
news.notice 		-/var/log/news/news.notice
*.=warning;*.=err 	-/var/log/warn
*.crit 			/var/log/warn
# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none	-/var/log/messages
local0.*,local1.* 	-/var/log/localmessages
local2.*,local3.* 	-/var/log/localmessages
local4.*,local5.* 	-/var/log/localmessages
local6.*		-/var/log/localmessages
local7.*		/var/log/boot.log
# Save news errors of level crit and higher in a special file.
uucp,news.crit		/var/log/spooler
EOF
# Fin: HARDE-RHEL-235
