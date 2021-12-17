#! /bin/bash
# -*- mode: shell; coding: utf-8-unix -*-
# If there is a secure.sh script use it and create a 21_automatic_apply.md
#   or otherwise rely on 20_apply.md
# and concatenate all these files to $1

[ -d docs ] && [ -d hardening ] || exit 2
exec 1>"$1"

APPLY_DOC="20_apply.md"
AUTOMATIC_APPLY="21_automatic_apply.md"

cd ./hardening || exit

for i in HARDE-RHEL-???; do
    cd "$i" || exit
    cat 00_intro.md 10_references.md
    # do not overwrite if there is an existing file, not using a shell script
    if [ -e secure.sh ]; then
        [ -e $APPLY_DOC ] && rm $APPLY_DOC
        if [ ! -e $AUTOMATIC_APPLY ] || [ secure.sh -nt $AUTOMATIC_APPLY ]; then
            (
                exec 1>$AUTOMATIC_APPLY
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
        cat $AUTOMATIC_APPLY
    else
        cat $APPLY_DOC
    fi
    [ -e 30_outro.md ] && cat 30_outro.md
    cd ..
done
