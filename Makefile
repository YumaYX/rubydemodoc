default:
	cat Makefile

delmd:
	find input -name "*.md" | xargs rm -v

delmdempty:
	find input -name "*.md" -empty | xargs rm -v

