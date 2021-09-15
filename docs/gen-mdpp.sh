#! /usr/bin/env bash
# -*- mode: shell; coding: utf-8-unix -*-

[ -d docs ] && [ -d hardening ] || exit 2
exec 1>docs/harde-doc.mdpp
cd ./hardening
cat intro.md
for i in HARDE-RHEL-???
do
    cd $i
    cat 00_intro.md
    echo
    cat 10_references.md
    echo 
    echo '#### Méthode à suivre'
    echo 
    echo "!IFEXISTS \"./hardening/$i/secure.sh\""
    echo "Pour se faire utiliser le script fourni, dont voici le code source concernant $i:"
    echo "!INCLUDECODE \"./hardening/$i/secure.sh\" (bash)"
    echo "!ENDIFEXISTS"

    cat 30_outro.md
    cd ..
done
cat outro.md

