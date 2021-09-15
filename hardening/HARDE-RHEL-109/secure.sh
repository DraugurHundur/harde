echo "HARDE-RHEL-109 : Afficher des bannières lors de la connexion"
for i in /etc/motd /etc/issue /etc/issue.net; do
  cat >"$i" <<EOF
***************************************************************************
*L’utilisation d’un poste classifié n’est autorisée qu’aux personnes ayant* 
*le niveau d’habilitation requis.                                         *
*Tout manquement à cette règle est considéré comme une compromission du   *
* secret de la défense nationale et entraine une poursuite judicaire.     *    
*                                  (Art. 66. IGI 1300 du 30 novembre 2011)* 
***************************************************************************
EOF
done
# Fin: HARDE-RHEL-109
