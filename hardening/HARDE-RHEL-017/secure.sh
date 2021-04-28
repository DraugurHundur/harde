#! /usr/bin/env bash
echo "HARDE-RHEL-17 : S'assurer de la configuration de /var"
mount | grep -E '\s/var\s' | grep -q nodev || echo "Configuration non valide pour /var"
# Fin: HARDE-RHEL-17
