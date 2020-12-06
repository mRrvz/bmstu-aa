CC := g++
OBJ = src/*.cxx
APPNAME := app.exe
FLAGS=-lpthread -O0 -Wall -lpthread -pg -lc
DEBUG_FLAGS=-D__DEBUG__ -g

build:
	$(CC) -o $(APPNAME) $(OBJ) $(FLAGS)

debug:
	$(CC) -o $(APPNAME) $(OBJ) $(FLAGS) $(DEBUG_FLAGS)

clean:
	rm -rf *.exe *.out && cd src && rm -rf *.o *.hi *.exe *.out

run: build
	./$(APPNAME)

prof: run
	gprof ${APPNAME} gmon.out -p
