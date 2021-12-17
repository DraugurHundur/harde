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

D=docs
## Pandoc options to use for all document types
#OPTIONS=-r markdown+simple_tables+table_captions+yaml_metadata_block+smart
OPTIONS=
## Pandoc custom filters
FILTERS=-L $(D)/panda.lua -L $(D)/custom.lua

all: $(D)/harde-doc.html $(D)/harde-doc.docx $(D)/harde-items.txt
.PHONY: clean check

hardening/rules.md: hardening/HARDE-RHEL-*/secure.sh hardening/HARDE-RHEL-*/20_apply.md
>bash $(D)/generate_rules_md.sh $@

$(D)/harde-doc.html: hardening/intro.md hardening/rules.md hardening/outro.md $(D)/template.html $(D)/panda.lua
#  --shift-heading-level-by=1 only works with the latest version of pandoc
>pandoc $(OPTIONS) $(FILTERS) hardening/intro.md hardening/rules.md hardening/outro.md -w html --template $(D)/template.html --standalone --toc --resource-path=$(D) -o $@

$(D)/harde-doc.docx: hardening/intro.md hardening/rules.md hardening/outro.md $(D)/template.html $(D)/panda.lua
>pandoc $(OPTIONS) $(FILTERS) hardening/intro.md hardening/rules.md hardening/outro.md -w docx --reference-doc=$(D)/custom-reference.docx --standalone --toc --resource-path=$(D) -o $(D)/harde-doc.docx
# breaks tables if they have one cell containing <br>
>pandoc -t latex $(FILTERS) --resource-path=$(D) hardening/intro.md hardening/rules.md hardening/outro.md | pandoc -f latex --standalone --resource-path=$(D) --reference-doc=$(D)/custom-reference.docx --toc -o $(D)/harde-doc2.docx

$(D)/harde-items.txt:  hardening/HARDE-RHEL-*/00_intro.md
>grep -h '^## ' hardening/HARDE-RHEL-???/00_intro.md >$(D)/harde-items.txt

$(D)/panda.lua:
>wget https://raw.githubusercontent.com/CDSoft/panda/master/panda.lua -O $@

clean:
>rm -f $(D)/harde-items.txt hardening/rules.md $(D)/harde-doc.md $(D)/harde-doc.html

# requires shfmt 
check: hardening/HARDE-RHEL-*/secure.sh hardening/*.sh *.sh
>shfmt -ci -i 4 -d . >/dev/null
