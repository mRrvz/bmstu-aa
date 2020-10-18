CC := gcc
OBJ = main.c multiplication.c
APPNAME := app.exe

build:
	cd src && $(CC) -o $(APPNAME) $(FLAGS) $(OBJ) && mv app.exe ../

clean:
	rm *.exe *.out && cd src && rm *.o *.hi *.exe *.out

run: app.exe
	./$(APPNAME)
