CC=ocamlc
FLAGS=-c

build:
	cd src && \
		$(CC) $(FLAGS) Sorts.mli && \
		$(CC) $(FLAGS) Sorts.ml && \
		$(CC) $(FLAGS) Main.ml && \
		$(CC) -o ../app.exe Sorts.ml Main.ml

tests:
	cd src && \
		$(CC) $(FLAGS) Sorts.mli && \
		$(CC) $(FLAGS) Sorts.ml && \
		$(CC) $(FLAGS) -pp camlp4o Tests.ml && \
		$(CC) -o ../tests.exe Sorts.ml Tests.ml

run: app.exe
	./app.exe

run_tests: tests.exe
	./tests.exe

clean:
	rm -rf *.exe *.out src/*.cmo src/*.cmi src/*.cmx src/*.o *.cmi
