
### Méthode à suivre

Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant HARDE-RHEL-128 :

``` {.bash .numberLines}
echo "HARDE-RHEL-128 : Protection des mots de passe stockés"
if ! grep -q -E '^ENCRYPT_METHOD\s+SHA512' /etc/login.defs; then
  sed -e 's/\(ENCRYPT_METHOD.*\)/# \1/' -i /etc/login.defs
  echo "ENCRYPT_METHOD SHA512" >>/etc/login.defs
fi
if ! grep -q -E '^SHA_CRYPT_MIN_ROUNDS\s+65536' /etc/login.defs; then
  sed -e 's/\(SHA_CRYPT_MIN_ROUNDS.*\)/# \1/' -i /etc/login.defs
  echo "SHA_CRYPT_MIN_ROUNDS 65536" >>/etc/login.defs
fi
AUTH_FILES=(
  [0]="/etc/pam.d/system-auth"
  [1]="/etc/pam.d/password-auth"
)
for pamFile in "${AUTH_FILES[@]}"; do
  # suppress partial config and nullok
  sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ nullok//" "$pamFile"
  sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ sha512//" "$pamFile"
  sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ obscure//" "$pamFile"
  sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/ rounds=65536//" "$pamFile"
  if ! grep -q "^password.*sufficient.*pam_unix.so.*obscure sha512 rounds=65536" "$pamFile"; then
    sed -i --follow-symlinks "/^password.*sufficient.*pam_unix.so/ s/$/ obscure sha512 rounds=65536/" "$pamFile"
  fi
done
# Fin: HARDE-RHEL-128
```

