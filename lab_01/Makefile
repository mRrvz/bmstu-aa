CC := ghc
MAIN := Main.hs
APPNAME := app.exe

build:
	cd src && $(CC) -o $(APPNAME) --make $(MAIN) -package clock -package timeit -package parallel-3.2.2.0 && mv app.exe ../

clean:
	rm *.o *.hi *.exe *.out

run: build
	./$(APPNAME)
