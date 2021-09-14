#! /bin/bash
echo "HARDE-RHEL-12 : Partition séparée pour /home"
mount |grep -q -E '/home\s' || echo "ERREUR: /home n'est pas une partition séparée !"
# Fin: HARDE-RHEL-12
