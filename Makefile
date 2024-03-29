build:
	dune build

utop:
	dune utop src

ustove:
	dune exec bin/ustove.exe

mealguess:
	dune exec bin/mealguess.exe
	
menu:
	dune exec bin/menu.exe

.PHONY: test
test:
	dune exec test/test.exe

clean: bisect-clean
	dune clean

zip:
	rm -f iCook.zip
	zip -r iCook.zip . -x@exclude.lst

bisect: bisect-clean
	-dune exec --instrument-with bisect_ppx test/test.exe
	bisect-ppx-report html

bisect-clean:
	rm -rf _coverage bisect*.coverage

cloc:
	dune clean
	cloc --by-file --include-lang=OCaml .
	dune build

parse_explain:
	menhir src/parser.mly --explain

doc:
	dune build @doc

opendoc: doc
	@bash opendoc.sh