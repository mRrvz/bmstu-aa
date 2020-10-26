CC := gcc
OBJ = src/*.c
APPNAME := app.exe
FLAGS=-lpthread -O0 -std=c99 -Wall -pg -lc
DEBUG_FLAGS=-D__DEBUG__ -g
THREADS=16
TYPE=1

build:
	$(CC) -o $(APPNAME) $(OBJ) $(FLAGS)

debug:
	$(CC) -o $(APPNAME) $(OBJ) $(FLAGS) $(DEBUG_FLAGS)

clean:
	rm -rf *.exe *.out && cd src && rm -rf *.o *.hi *.exe *.out

run: build
	./$(APPNAME) ${THREADS} ${TYPE}

prof: run
	gprof ${APPNAME} gmon.out -p
