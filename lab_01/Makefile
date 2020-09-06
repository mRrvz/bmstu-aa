CC := ghc
MAIN := Main.hs
APPNAME := app.exe

build:
	cd src && $(CC) -o $(APPNAME) --make $(MAIN) -package clock -package timeit&& mv app.exe ../

clean:
	rm *.o *.hi *.exe *.out

run: build
	./$(APPNAME)
