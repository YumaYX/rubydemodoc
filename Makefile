default:
	cat Makefile

delmd:
	find input -name "*.md" | xargs rm -fv

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
	find doctree/refm/api/src -type f | while read line; do cp -v $$line docs/; done
	make pythonenv

cleandocs:
	rm -rf docs doctree venv

################
pythonenv:
	python3.13 -m venv venv
	source venv/bin/activate && pip3.13 install -r requirements.txt
	source venv/bin/activate && python3.13 llm/build_index.py
