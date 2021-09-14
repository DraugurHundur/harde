all: doc index

docs/harde-doc.md: docs/harde-doc.mdpp
	markdown-pp docs/harde-doc.mdpp -o docs/harde-doc.md
docs/harde-doc.mdpp:
	bash docs/gen-mdpp.sh

doc: docs/harde-doc.md
	pandoc docs/harde-doc.md -f gfm -t html  --metadata title="HARDEning RHEL" -s -o docs/harde-doc.html

index:  hardening/HARDE-RHEL-*/00_intro.md docs/harde-items.txt

docs/harde-items.txt:
	grep -h '^## ' hardening/HARDE-RHEL-???/00_intro.md >docs/harde-items.txt

cleandoc:
	rm -f docs/harde-items.txt docs/harde-doc.md docs/harde-doc.html
