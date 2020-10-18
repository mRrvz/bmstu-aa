CC := gcc
OBJ = src/*.c
APPNAME := app.exe
FLAGS=-lpthread -O0 -std=c99 -Wall

build:
	$(CC) -o $(APPNAME) $(OBJ) $(FLAGS)

debug:
	$(CC) -o $(APPNAME) $(OBJ) $(FLAGS) -D__DEBUG__

clean:
	rm *.exe *.out && cd src && rm *.o *.hi *.exe *.out

run: app.exe
	./$(APPNAME)
