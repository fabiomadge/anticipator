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
	ls *.java

clean:
	rm -f src/*.class
	rm -f listTest.jar
