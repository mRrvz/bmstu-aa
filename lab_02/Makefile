CC := ghc
MAIN := Main.hs
APPNAME := app.exe
FLAGS=-dynamic --make -O0

build:
	cd src && $(CC) -o $(APPNAME) $(FLAGS) $(MAIN) && mv app.exe ../

clean:
	cd src && rm *.o *.hi *.exe *.out

run: app.exe
	./$(APPNAME)
