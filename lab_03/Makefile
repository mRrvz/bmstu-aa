CC=ocamlc
FLAGS=-c

build:
	cd src && \
		$(CC) $(FLAGS) Sorts.mli && \
		$(CC) $(FLAGS) Sorts.ml && \
		$(CC) $(FLAGS) Main.ml && \
		$(CC) -o ../app.exe Sorts.ml Main.ml

run: app.exe
	./app.exe

clean:
	rm -rf *.exe *.out src/*.cmo src/*.cmi src/*.cmx src/*.o *.cmi
