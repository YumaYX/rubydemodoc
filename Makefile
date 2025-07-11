default:
	cat Makefile

delmd:
	find input -name "*.md" | xargs rm -fv

delmdempty:
	find input -name "*.md" -empty | xargs rm -fv

