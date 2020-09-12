CC := ghc
MAIN := Main.hs
APPNAME := app.exe

build:
	cd src && $(CC) -o $(APPNAME) -dynamic --make $(MAIN) -package clock -package parallel-3.2.2.0 && mv app.exe ../

clean:
	cd src && rm *.o *.hi *.exe *.out

run: build
	./$(APPNAME)
