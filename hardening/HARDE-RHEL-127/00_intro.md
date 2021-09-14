### HARDE-RHEL-127 : S'assurer que la réutilisation d'anciens mots de passe soit limitée

#### Description
Cette règle vise à limiter la réutilisation des anciens mots de passe. Elle s'appuie sur le module PAM pam_pwhistory et est implémenté sur le système par la règle HARDE-RHEL-137.

UTiliser pam_unix pour cette option n'est pas recommandé car il stocke des agrégats MD5 (alors que pam_pwhistory stocke en sha512)
