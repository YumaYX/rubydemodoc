default:
	cat Makefile

delmd:
	find input -name "*.md" | xargs rm -v

