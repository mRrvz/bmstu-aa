CC := ghc
MAIN := Main.hs
APPNAME := app.exe

build:
	cd src && $(CC) -o $(APPNAME) --make $(MAIN) && mv app.exe ../

clean:
	rm *.o *.hi *.exe *.out

run: build
	./$(APPNAME)

