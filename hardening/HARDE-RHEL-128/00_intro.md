## HARDE-RHEL-128 : Protection des mots de passe stockés

### Description

Red Hat 8 est partiellement conforme par défaut :
 - Supprimer la paramètre null_ok si présent dans /etc/pam.d/system-auth et /etc/pam.d/password-auth.
 - S'assurer que les fichiers /etc/pam.d/system-auth et /etc/pam.d/password-auth contienne:
    password required pam_unix.so obscure sha512 rounds=65536
 - S'assurer que le fichier /etc/login.defs contienne : 
  ENCRYPT_METHOD SHA512
  SHA_CRYPT_MIN_ROUNDS 65536

