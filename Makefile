all: doc index

docs/harde-doc.md: docs/harde-doc.mdpp
	markdown-pp docs/harde-doc.mdpp -o docs/harde-doc.md

docs/harde-doc.mdpp:
	bash docs/gen-mdpp.sh

doc: docs/harde-doc.md
	pandoc docs/harde-doc.md --shift-heading-level-by=1 -f gfm -t html5 --metadata title="HARDE : SÉCURISATION D'UN SYSTÈME RED HAT 8.x" --standalone -o docs/harde-doc.html

index:  hardening/HARDE-RHEL-*/00_intro.md docs/harde-items.txt

docs/harde-items.txt:
	grep -h '^### ' hardening/HARDE-RHEL-???/00_intro.md >docs/harde-items.txt

cleandoc:
	rm -f docs/harde-items.txt docs/harde-doc.mdpp docs/harde-doc.md docs/harde-doc.html

# requires shfmt 
check: hardening/HARDE-RHEL-*/secure.sh *.sh
	shfmt -ci -i 4 -d . >/dev/null