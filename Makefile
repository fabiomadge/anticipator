all: build

build:
	ghc --make -O src/Main -o anticipator
	@echo 'Done!'
	@echo 'Run: ./anticipator [<args>]'

help:
	@echo "Usage: make <commands>\n"
	@echo "The commands are:"
	@echo "	all         Default target, runs build"
	@echo "	build       Compiles the sources."
	@echo "	help        Prints this help."
	@echo "	list        Lists all source files."
	@echo "	clean       Deletes the binarie and build files.\n"
list:
	@cd src; \
	ls *.hs

clean:
	rm -f src/*.hi
	rm -f src/*.o
	rm -f src/anticipator
	rm -f anticipator
