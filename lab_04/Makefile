CC := ghc
MAIN := Main.hs
APPNAME := app.exe
FLAGS=-dynamic --make -O0 -threaded

build:
	cd src && $(CC) -o $(APPNAME) $(FLAGS) $(MAIN) && mv app.exe ../

clean:
	rm *.exe *.out && cd src && rm *.o *.hi *.exe *.out

run: app.exe
	./$(APPNAME)
