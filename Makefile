all: doc

doc: docs/harde-doc.md
	markdown-pp docs/harde-doc.mdpp -o docs/harde-doc.md
	pandoc docs/harde-doc.md -f markdown -t html  --metadata title="HARDEning RHEL" -s -o docs/harde-doc.html
