CC=gcc
FLAGS=-pg -Wall -O0 -lc

build:
	$(CC) main2.c $(FLAGS) -o app.exe

run: build
	./app.exe

prof: run
	gprof app.exe gmon.out -p  

clean:
	rm *.exe *.out
