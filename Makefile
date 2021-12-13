SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

all: docs/harde-doc.html docs/harde-doc.docx docs/harde-items.txt
.PHONY: clean check

hardening/rules.md: hardening/HARDE-RHEL-*/secure.sh hardening/HARDE-RHEL-*/20_apply.md
>bash docs/generate_rules_md.sh $@

docs/harde-doc.html: hardening/intro.md hardening/rules.md hardening/outro.md docs/template.html
#  --shift-heading-level-by=1 only works with the latest version of pandoc
>pandoc hardening/intro.md hardening/rules.md hardening/outro.md --template docs/template.html --standalone --toc --resource-path=docs -o docs/harde-doc.html

docs/harde-doc.docx: hardening/intro.md hardening/rules.md hardening/outro.md docs/template.html
>pandoc hardening/intro.md hardening/rules.md hardening/outro.md -t docx --reference-doc=docs/custom-reference.docx --standalone --toc --resource-path=docs -o docs/harde-doc.docx

docs/harde-items.txt:  hardening/HARDE-RHEL-*/00_intro.md
>grep -h '^## ' hardening/HARDE-RHEL-???/00_intro.md >docs/harde-items.txt

clean:
>rm -f docs/harde-items.txt hardening/rules.md docs/harde-doc.md docs/harde-doc.html

# requires shfmt 
check: hardening/HARDE-RHEL-*/secure.sh hardening/*.sh *.sh
>shfmt -ci -i 4 -d . >/dev/null
