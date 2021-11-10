#! /bin/bash
# -*- mode: shell; coding: utf-8-unix -*-

[ -d docs ] && [ -d hardening ] || exit 2
exec 1>docs/harde-doc.md
cd ./hardening || exit
cat intro.md
for i in HARDE-RHEL-???; do
    cd "$i" || exit
    cat 00_intro.md 
    echo 
    cat 10_references.md 2>/dev/null
    # do not overwrite if there is an existing file, not using a shell script
    if [ ! -e 20_apply.md ]; then
        echo
        echo "### Méthode à suivre"
        echo 
        echo "Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant $i :"
        echo '``` {.bash .numberLines}'
        cat secure.sh
        echo '```'
    else
        cat 20_apply.md
    fi
    echo 
    cat 30_outro.md
    cd ..
done
cat outro.md
