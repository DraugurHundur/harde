#! /bin/bash
# -*- mode: shell; coding: utf-8-unix -*-
# If there is a secure.sh script use it and create a 21_automatic_apply.md
#   or otherwise rely on 20_apply.md
# and concatenate all these files to $1

[ -d docs ] && [ -d hardening ] || exit 2
exec 1>"$1"

cd ./hardening || exit

for i in HARDE-RHEL-???; do
    cd "$i" || exit
    cat 00_intro.md 10_references.md
    # do not overwrite if there is an existing file, not using a shell script
    if [ ! -e 20_apply.md ]; then
        # Create the 21_automatic_apply.mf if needed
        if [ ! -e 21_automatic_apply ] || [ secure.sh -nt 21_automatic_apply ]; then
            (
                exec 1>21_automatic_apply.md
                echo
                echo "### Méthode à suivre"
                echo
                echo "Pour implémenter cette règle, utiliser le script fourni, dont voici un extrait du code source concernant $i :"
                echo
                echo '``` {.bash .numberLines}'
                cat secure.sh || echo "Can't open the hardening script in $PWD" 1>&2
                echo '```'
                echo
            )
        fi
        cat 21_automatic_apply.md
    else
        cat 20_apply.md
        [ -e secure.sh ] && (
            cat secure.sh
            echo "Skipped/ignored hardening script in $PWD"
        ) 1>&2
    fi
    [ -e 30_outro.md ] && cat 30_outro.md
    cd ..
done
