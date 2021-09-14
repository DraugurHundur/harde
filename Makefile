all: doc index

doc: docs/harde-doc.md
	markdown-pp docs/harde-doc.mdpp -o docs/harde-doc.md
	pandoc docs/harde-doc.md -f markdown -t html  --metadata title="HARDEning RHEL" -s -o docs/harde-doc.html

index: docs/harde-items.txt hardening/HARDE-RHEL-*/00_intro.md
	grep -h '^## ' hardening/HARDE-RHEL-???/00_intro.md >docs/harde-items.txt
