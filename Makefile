all: docs/harde-doc.html docs/harde-items.txt
.PHONY: clean check

docs/harde-doc.md: hardening/intro.md hardening/outro.md 
	bash docs/gen-mdpp.sh

docs/harde-doc.html: docs/harde-doc.md docs/template.html
#  --shift-heading-level-by=1 only works with the latest version of pandoc
	pandoc docs/harde-doc.md --template docs/template.html --standalone --toc -o docs/harde-doc.html

docs/harde-items.txt:  hardening/HARDE-RHEL-*/00_intro.md
	grep -h '^## ' hardening/HARDE-RHEL-???/00_intro.md >docs/harde-items.txt

clean:
	rm -f docs/harde-items.txt docs/harde-doc.mdpp docs/harde-doc.md docs/harde-doc.html

# requires shfmt 
check: hardening/HARDE-RHEL-*/secure.sh hardening/*.sh *.sh
	shfmt -ci -i 4 -d . >/dev/null
