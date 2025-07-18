default:
	cat Makefile | grep -E "^.?*:" | grep -Pv '^\t'

delmd:
	find input -name "*.md" | xargs rm -fv

md: delmd
	rake

delmdempty:
	find input -name "*.md" -empty | xargs rm -fv


clonerubydoc:
	-git clone https://github.com/rurema/doctree.git

ollamamodel:
	-ollama pull nomic-embed-text:latest
	-ollama pull gemma3
	-ollama pull gemma3n

rag: ollamamodel cleandocs clonerubydoc
	mkdir -p docs
	find doctree/refm -type f | while read line; do cp -v $$line docs/; done
	make pythonenv
	source venv/bin/activate && python3.13 llm/build_index.py

cleandocs:
	rm -rf docs doctree venv

################
pythonenv:
	python3.13 -m venv venv
	source venv/bin/activate && pip3.13 install -r requirements.txt
